#!/bin/bash

# Script to generate docker-bake.hcl dynamically from Dockerfile metadata
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
BAKE_FILE="$PROJECT_ROOT/docker-bake.hcl"

# Function to extract metadata from Dockerfile
extract_metadata() {
    local dockerfile="$1"
    local tags platforms variant

    tags=$(grep "^# TAGS:" "$dockerfile" | sed 's/^# TAGS: *//' || echo "")
    variant=$(grep "^# VARIANT:" "$dockerfile" | sed 's/^# VARIANT: *//' || echo "")
    platforms=$(grep "^# PLATFORMS:" "$dockerfile" | sed 's/^# PLATFORMS: *//' || echo "")

    echo "$tags|$variant|$platforms"
}

# Function to generate target name from path
generate_target_name() {
    local path="$1"
    # Convert path like "20/alpine" or "20/dev/alpine" to "20-alpine" or "20-dev-alpine"
    echo "$path" | sed 's|/|-|g'
}

# Function to generate tags for a target
generate_tags() {
    local dockerfile_tags="$1"
    local variant="$2"
    local node_version="$3"
    local is_dev="$4"

    local tags=()

    # Add version-specific tags
    if [ "$is_dev" = "true" ]; then
        tags+=("$node_version-dev")
        if [ -n "$variant" ]; then
            tags+=("$node_version-dev-$variant")
        fi
    else
        tags+=("$node_version")
        if [ -n "$variant" ]; then
            tags+=("$node_version-$variant")
        fi
    fi

    # Add alias tags from Dockerfile
    if [ -n "$dockerfile_tags" ]; then
        IFS=',' read -ra tag_array <<< "$dockerfile_tags"
        for tag in "${tag_array[@]}"; do
            tag=$(echo "$tag" | xargs) # trim whitespace
            if [ "$is_dev" = "true" ]; then
                tags+=("$tag-dev")
                if [ -n "$variant" ]; then
                    tags+=("$tag-dev-$variant")
                fi
            else
                tags+=("$tag")
                if [ -n "$variant" ]; then
                    tags+=("$tag-$variant")
                fi
            fi
        done
    fi

    # Convert to JSON-like format for HCL
    printf '%s' "$(printf '"%s",' "${tags[@]}" | sed 's/,$//')"
}

# Start generating the bake file
cat > "$BAKE_FILE" << 'EOF'
variable "REGISTRY" {
  default = ["docker.io/hazmi35", "ghcr.io/hazmi35"]
}

variable "METADATA_TAGS" {
  default = ""
}

variable "METADATA_LABELS" {
  default = ""
}

variable "PUSH" {
  default = false
}

EOF

# Arrays to track groups
version_groups=""
all_targets=""

# Find all Dockerfiles and process them
while IFS= read -r -d '' dockerfile; do
    # Skip .devcontainer
    if [[ "$dockerfile" == *".devcontainer"* ]]; then
        continue
    fi

    # Get relative path from project root
    rel_path="${dockerfile#$PROJECT_ROOT/}"
    dir_path="$(dirname "$rel_path")"

    # Extract metadata
    metadata=$(extract_metadata "$dockerfile")
    IFS='|' read -r tags variant platforms <<< "$metadata"

    # Determine node version and if it's dev
    node_version=""
    is_dev="false"
    if [[ "$dir_path" =~ ^([0-9]+)/(dev/)?(alpine|debian)$ ]]; then
        node_version="${BASH_REMATCH[1]}"
        if [ -n "${BASH_REMATCH[2]}" ]; then
            is_dev="true"
        fi
    elif [[ "$dir_path" =~ ^([0-9]+)/(alpine|debian)$ ]]; then
        node_version="${BASH_REMATCH[1]}"
    fi

    if [ -z "$node_version" ]; then
        echo "Warning: Could not determine Node.js version from path: $dir_path" >&2
        continue
    fi

    # Generate target name
    target_name=$(generate_target_name "$dir_path")

    # Generate tags
    target_tags=$(generate_tags "$tags" "$variant" "$node_version" "$is_dev")

    # Convert platforms to JSON array format
    if [ -n "$platforms" ]; then
        platform_array=$(echo "$platforms" | sed 's/, */", "/g' | sed 's/^/"/' | sed 's/$/"/')
    else
        platform_array='"linux/amd64", "linux/arm64"'
    fi

    # Add to version groups (using string concatenation)
    version_groups="$version_groups$node_version:$target_name;"

    # Add to all targets
    if [ -z "$all_targets" ]; then
        all_targets="\"$target_name\""
    else
        all_targets="$all_targets, \"$target_name\""
    fi

    # Write target configuration
    cat >> "$BAKE_FILE" << EOF
# $dir_path
target "$target_name" {
  context    = "./$dir_path"
  dockerfile = "Dockerfile"
  platforms  = [$platform_array]
  tags       = formatlist("%s/node:%s", REGISTRY, [$target_tags])
  labels     = split(",", METADATA_LABELS)
  push       = PUSH
}

EOF

done < <(find "$PROJECT_ROOT" -name "Dockerfile" -type f -print0)

# Write group configurations
echo "" >> "$BAKE_FILE"
echo "# Groups by Node.js version" >> "$BAKE_FILE"

# Parse version_groups string and create groups
for version_entry in $(echo "$version_groups" | tr ';' '\n' | grep -v '^$'); do
    version=$(echo "$version_entry" | cut -d':' -f1)
    target=$(echo "$version_entry" | cut -d':' -f2)

    # Check if group already exists in file
    if ! grep -q "group \"node-$version\"" "$BAKE_FILE"; then
        # Create new group
        echo "group \"node-$version\" {" >> "$BAKE_FILE"
        echo "  targets = [$target]" >> "$BAKE_FILE"
        echo "}" >> "$BAKE_FILE"
        echo "" >> "$BAKE_FILE"
    else
        # Add target to existing group
        sed -i.bak "/group \"node-$version\"/ {
            n
            s/targets = \[\([^]]*\)\]/targets = [\1, $target]/
        }" "$BAKE_FILE" && rm -f "$BAKE_FILE.bak"
    fi
done

# Write all group
echo "# All targets" >> "$BAKE_FILE"
printf 'group "all" {\n  targets = [%s]\n}\n' "$all_targets" >> "$BAKE_FILE"

echo "Generated $BAKE_FILE successfully!"

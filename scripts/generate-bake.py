#!/usr/bin/env python3
"""
Generate docker-bake.hcl from Dockerfile metadata and detect changes
"""

import os
import re
import subprocess
import sys
from collections import defaultdict
from pathlib import Path


def extract_metadata(dockerfile_path):
    """Extract metadata from Dockerfile comments"""
    metadata = {"tags": "", "variant": "", "platforms": ""}

    with open(dockerfile_path, "r") as f:
        content = f.read()

    # Extract metadata from comments
    for line in content.split("\n"):
        if line.startswith("# TAGS:"):
            metadata["tags"] = line.replace("# TAGS:", "").strip()
        elif line.startswith("# VARIANT:"):
            metadata["variant"] = line.replace("# VARIANT:", "").strip()
        elif line.startswith("# PLATFORMS:"):
            metadata["platforms"] = line.replace("# PLATFORMS:", "").strip()

    return metadata


def generate_target_name(path):
    """Generate target name from path"""
    return path.replace("/", "-")


def generate_tags(dockerfile_tags, variant, node_version, is_dev):
    """Generate tags for a target"""
    tags = []

    # Determine base variant suffix
    if is_dev:
        if variant == "dev":
            # For debian dev images, variant is just "dev"
            base_suffix = "dev"
        elif variant == "dev-alpine":
            # For alpine dev images, variant is "dev-alpine"
            base_suffix = "dev-alpine"
        else:
            base_suffix = "dev"
    else:
        if variant == "alpine":
            base_suffix = "alpine"
        else:
            base_suffix = ""

    # Add version-specific tags
    tags.append(node_version)
    if base_suffix:
        tags.append(f"{node_version}-{base_suffix}")

    # Add alias tags from Dockerfile
    if dockerfile_tags:
        tag_list = [tag.strip() for tag in dockerfile_tags.split(",")]
        for tag in tag_list:
            tags.append(tag)
            if base_suffix:
                tags.append(f"{tag}-{base_suffix}")

    return tags


def get_changed_files():
    """Detect changed files using git"""
    try:
        # Check if we're in a git repository
        subprocess.run(
            ["git", "rev-parse", "--git-dir"], capture_output=True, check=True
        )

        # Try to detect what kind of change we're dealing with
        github_event = os.environ.get("GITHUB_EVENT_NAME")

        if github_event == "workflow_dispatch":
            return "all"
        elif github_event == "pull_request":
            # For PRs, compare against base branch
            base_ref = os.environ.get("GITHUB_BASE_REF", "main")
            result = subprocess.run(
                ["git", "diff", "--name-only", f"origin/{base_ref}...HEAD"],
                capture_output=True,
                text=True,
                check=True,
            )
        else:
            # For pushes, compare with previous commit
            result = subprocess.run(
                ["git", "diff", "--name-only", "HEAD~1..HEAD"],
                capture_output=True,
                text=True,
                check=True,
            )

        changed_files = (
            result.stdout.strip().split("\n") if result.stdout.strip() else []
        )

        # Filter for relevant files
        dockerfiles = []
        for file in changed_files:
            if "Dockerfile" in file and ".devcontainer" not in file:
                dockerfiles.append(file)
            elif file.startswith("scripts/"):
                return "all"  # Script changes require rebuilding all

        return dockerfiles if dockerfiles else "none"

    except (subprocess.CalledProcessError, FileNotFoundError):
        return "all"


def dockerfile_to_target(dockerfile_path):
    """Convert Dockerfile path to Docker Bake target name"""
    # Extract pattern: version/[dev/]variant/Dockerfile -> version-[dev-]variant
    parts = Path(dockerfile_path).parts

    for i, part in enumerate(parts):
        if re.match(r"^\d+$", part):  # Found version number
            version = part
            remaining = parts[i + 1 : -1]  # Everything except 'Dockerfile'
            if remaining:
                return f"{version}-{'-'.join(remaining)}"

    return None


def get_targets_from_dockerfiles(dockerfiles):
    """Convert list of Dockerfile paths to target names"""
    if dockerfiles == "all" or dockerfiles == "none":
        return dockerfiles

    targets = set()
    for dockerfile in dockerfiles:
        target = dockerfile_to_target(dockerfile)
        if target:
            targets.add(target)

    return ",".join(sorted(targets)) if targets else "none"


def main():
    script_dir = Path(__file__).parent
    project_root = script_dir.parent
    bake_file = project_root / "docker-bake.hcl"

    # Handle change detection
    if "--detect-changes" in sys.argv:
        changed_files = get_changed_files()
        targets = get_targets_from_dockerfiles(changed_files)

        print(f"CHANGED_FILES={changed_files}")
        print(f"TARGETS={targets}")
        return

    # Start building the bake file content
    bake_content = """variable "PUSH" {
  default = false
}

variable "METADATA_LABELS" {
  default = {}
}

"""

    version_groups = defaultdict(list)
    all_targets = []

    # Find all Dockerfiles
    dockerfiles = list(project_root.glob("**/Dockerfile"))

    for dockerfile in dockerfiles:
        # Skip .devcontainer
        if ".devcontainer" in str(dockerfile):
            continue

        # Get relative path from project root
        rel_path = dockerfile.relative_to(project_root)
        dir_path = str(rel_path.parent)

        # Extract metadata
        metadata = extract_metadata(dockerfile)

        # Determine node version and if it's dev
        node_version = None
        is_dev = False

        # Match patterns like "20/alpine", "20/dev/alpine", "20/debian", "20/dev/debian"
        if match := re.match(r"^(\d+)(?:/(dev))?/(alpine|debian)$", dir_path):
            node_version = match.group(1)
            is_dev = match.group(2) is not None

        if not node_version:
            print(f"Warning: Could not determine Node.js version from path: {dir_path}")
            continue

        # Generate target name
        target_name = generate_target_name(dir_path)

        # Generate tags
        tags = generate_tags(
            metadata["tags"], metadata["variant"], node_version, is_dev
        )

        # Convert platforms to list
        if metadata["platforms"]:
            platforms = [p.strip() for p in metadata["platforms"].split(",")]
        else:
            platforms = ["linux/amd64", "linux/arm64"]

        # Add to groups
        version_groups[node_version].append(target_name)
        all_targets.append(target_name)

        # Format tags and platforms for HCL
        registry_tags = []
        for registry in ["docker.io/hazmi35", "ghcr.io/hazmi35"]:
            for tag in tags:
                registry_tags.append(f'"{registry}/node:{tag}"')

        tags_hcl = ", ".join(registry_tags)
        platforms_hcl = ", ".join(f'"{platform}"' for platform in platforms)

        # Add target to bake file
        bake_content += f'''# {dir_path}
target "{target_name}" {{
  context    = "./{dir_path}"
  dockerfile = "Dockerfile"
  platforms  = [{platforms_hcl}]
  tags       = [{tags_hcl}]
  labels     = METADATA_LABELS
  push       = PUSH
}}

'''

    # Add group configurations
    bake_content += "\n# Groups by Node.js version\n"
    for version in sorted(version_groups.keys(), key=int):
        targets = version_groups[version]
        targets_hcl = ", ".join(f'"{target}"' for target in targets)
        bake_content += f"""group "node-{version}" {{
  targets = [{targets_hcl}]
}}

"""

    # Add all group
    all_targets_hcl = ", ".join(f'"{target}"' for target in all_targets)
    bake_content += f"""# All targets
group "all" {{
  targets = [{all_targets_hcl}]
}}
"""

    # Write the bake file
    with open(bake_file, "w") as f:
        f.write(bake_content)

    print(f"Generated {bake_file} successfully!")


if __name__ == "__main__":
    main()

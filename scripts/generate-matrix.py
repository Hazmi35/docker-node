#!/usr/bin/env python3
"""
Generate GitHub Actions matrix for parallel Docker builds
"""

import json
import re
import sys
from pathlib import Path


def get_all_targets():
    """Extract all target names from docker-bake.hcl"""
    script_dir = Path(__file__).parent
    project_root = script_dir.parent
    bake_file = project_root / "docker-bake.hcl"

    if not bake_file.exists():
        return []

    with open(bake_file, "r") as f:
        content = f.read()

    # Find all target definitions
    targets = re.findall(r'^target "([^"]+)"', content, re.MULTILINE)
    return sorted(targets)


def expand_groups(targets_input):
    """Expand group names to individual targets"""
    all_targets = get_all_targets()

    if targets_input == "all":
        return all_targets
    elif targets_input == "none" or not targets_input:
        return []

    expanded = set()
    for target in targets_input.split(","):
        target = target.strip()

        if target.startswith("node-"):
            # Handle version groups like "node-20", "node-22", etc.
            version = target.replace("node-", "")
            version_targets = [t for t in all_targets if t.startswith(f"{version}-")]
            expanded.update(version_targets)
        elif target == "all":
            expanded.update(all_targets)
        elif target in all_targets:
            expanded.add(target)
        else:
            # Silently skip unknown targets - they might be valid in different contexts
            pass

    return sorted(list(expanded))


def group_targets_by_version(targets):
    """Group targets by Node.js version for better resource utilization"""
    groups = {}

    for target in targets:
        # Extract version from target name (e.g., "20-alpine" -> "20")
        match = re.match(r"^(\d+)-", target)
        if match:
            version = match.group(1)
            if version not in groups:
                groups[version] = []
            groups[version].append(target)
        else:
            # Fallback group for targets that don't match pattern
            if "other" not in groups:
                groups["other"] = []
            groups["other"].append(target)

    return groups


def create_matrix(targets, max_parallel=None):
    """Create GitHub Actions matrix configuration"""
    if not targets:
        return {"include": []}

    matrix_items = []

    # Create matrix items
    for target in targets:
        # Extract version and variant info for better organization
        version_match = re.match(r"^(\d+)-(.*)", target)
        if version_match:
            version = version_match.group(1)
            variant = version_match.group(2)

            # Determine if this is a dev variant
            is_dev = "dev" in variant

            # Determine base OS
            os_type = "alpine" if "alpine" in variant else "debian"

            matrix_items.append(
                {
                    "target": target,
                    "version": version,
                    "variant": variant,
                    "is_dev": is_dev,
                    "os": os_type,
                }
            )
        else:
            # Fallback for targets that don't match expected pattern
            matrix_items.append(
                {
                    "target": target,
                    "version": "unknown",
                    "variant": "unknown",
                    "is_dev": False,
                    "os": "unknown",
                }
            )

    # Sort matrix items for consistent ordering
    # Sort by version (newest first), then dev vs non-dev, then alpine vs debian
    matrix_items.sort(
        key=lambda x: (
            -int(x["version"]) if x["version"].isdigit() else 999,
            not x["is_dev"],  # non-dev first
            x["os"] != "alpine",  # alpine first
        )
    )

    # Limit parallelism if requested
    if max_parallel and len(matrix_items) > max_parallel:
        print(
            f"Warning: Limiting parallel builds to {max_parallel} targets",
            file=sys.stderr,
        )
        matrix_items = matrix_items[:max_parallel]

    return {"include": matrix_items}


def main():
    targets_input = sys.argv[1] if len(sys.argv) > 1 else "all"
    max_parallel = None
    quiet = False

    # Parse remaining arguments
    for arg in sys.argv[2:]:
        if arg.isdigit():
            max_parallel = int(arg)
        elif arg == "--quiet" or arg == "-q":
            quiet = True

    # Expand groups to individual targets
    targets = expand_groups(targets_input)

    if not targets:
        print(json.dumps({"include": []}))
        return

    # Create matrix
    matrix = create_matrix(targets, max_parallel)

    # Output as JSON
    print(json.dumps(matrix, indent=2))

    # Only output debug info if running directly (not from workflow) and not in quiet mode
    if not quiet and sys.stdout.isatty():
        print(
            f"Generated matrix with {len(matrix['include'])} targets", file=sys.stderr
        )
        if targets:
            print(
                f"Targets: {', '.join(t['target'] for t in matrix['include'])}",
                file=sys.stderr,
            )


if __name__ == "__main__":
    main()

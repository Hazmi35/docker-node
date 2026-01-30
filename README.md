# docker-node
A repository that contains Docker (OCI format) base images for Node.js (that I used in my projects)

Available on [Docker Hub](https://hub.docker.com/r/hazmi35/node) and [GitHub Container Registry](https://github.com/Hazmi35/docker-node/pkgs/container/node)!

## Docker Images

### Base Images
The base images (`alpine` and `debian` variants) include:
- **Essential packages**: `tini`, `tzdata`, `ca-certificates` (Debian), networking tools
- **Proper signal handling**: Uses `tini` as entrypoint for graceful shutdown

### Development Images (`dev` variants)
The `dev` flavor images are designed for building Node.js applications and include:
- **Build tools**: `build-essential`/`build-base`, `git`, `python3`

These images are meant to be used in a [multi-stage build configuration](https://docs.docker.com/develop/develop-images/multistage-build/), where the dev image handles the build stage (installing deps, compiling, etc.) and the base image serves as the final production stage.

## Building with Docker Bake

This repository uses [Docker Bake](https://docs.docker.com/build/bake/) for efficient multi-platform builds. The build configuration is automatically generated from Dockerfile metadata comments.

### Quick Start

```bash
# Generate the bake configuration
python3 scripts/generate-bake.py

# Build all images
docker buildx bake all

# Build specific Node.js version
docker buildx bake node-25

# Build specific image variant
docker buildx bake 25-alpine
```

### Available Targets

- `all` - Build all images
- `node-22`, `node-24`, `node-25` - Build all variants for a specific Node.js version
- Individual targets like `25-alpine`, `25-debian`, `25-dev-alpine`, `25-dev-debian`

### Renovate

The build system maintains compatibility with [Renovate](https://renovatebot.com/) for automatic dependency updates. Each Dockerfile contains metadata comments that are parsed to generate the Docker Bake configuration:

```dockerfile
# TAGS: current, latest
# VARIANT: alpine
# PLATFORMS: linux/amd64, linux/arm64/v8, linux/s390x
FROM docker.io/library/node:25.2.1-alpine
```

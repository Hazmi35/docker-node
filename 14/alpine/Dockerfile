# TAGS: fermium
# VARIANT: alpine
# PLATFORMS: linux/amd64, linux/arm64/v8, linux/arm/v7, linux/arm/v6, linux/ppc64le, linux/s390x
FROM docker.io/library/node:14.20.1-alpine

# Set workdir.
WORKDIR /app

# Preinstalled packages
RUN apk add --no-cache \
    tini \
    tzdata

# Set entrypoint to use tini init
ENTRYPOINT [ "tini", "--", "docker-entrypoint.sh" ]

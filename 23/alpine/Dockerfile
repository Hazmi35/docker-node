# TAGS: current, latest
# VARIANT: alpine
# PLATFORMS: linux/amd64, linux/arm64/v8, linux/arm/v7, linux/arm/v6, linux/s390x
FROM docker.io/library/node:23.11.1-alpine

# Set workdir
WORKDIR /app

# Preinstalled packages
RUN apk add --no-cache \
    tini \
    tzdata

ENTRYPOINT [ "tini", "--", "docker-entrypoint.sh" ]

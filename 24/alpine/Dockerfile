# TAGS: current, latest, krypton
# VARIANT: alpine
# PLATFORMS: linux/amd64, linux/arm64/v8, linux/s390x
FROM docker.io/library/node:24.4.0-alpine

# Set workdir
WORKDIR /app

# Preinstalled packages
RUN apk add --no-cache \
    tini \
    tzdata

ENTRYPOINT [ "tini", "--", "docker-entrypoint.sh" ]

# TAGS: jod
# VARIANT: alpine
# PLATFORMS: linux/amd64, linux/arm64/v8, linux/arm/v7, linux/arm/v6, linux/s390x
FROM docker.io/library/node:22.22.0-alpine@sha256:e4bf2a82ad0a4037d28035ae71529873c069b13eb0455466ae0bc13363826e34

# Set workdir
WORKDIR /app

# Preinstalled packages
RUN apk add --no-cache \
    tini \
    tzdata

ENTRYPOINT [ "tini", "--", "docker-entrypoint.sh" ]

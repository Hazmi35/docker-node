# TAGS: iron, oldlts
# VARIANT: alpine
# PLATFORMS: linux/amd64, linux/arm64/v8, linux/arm/v7, linux/arm/v6, linux/ppc64le, linux/s390x
FROM docker.io/library/node:20.20.0-alpine@sha256:3960ed74dfe320a67bf8da9555b6bade25ebda2b22b6081d2f60fd7d5d430e9c

# Set workdir
WORKDIR /app

# Preinstalled packages
RUN apk add --no-cache \
    tini \
    tzdata

ENTRYPOINT [ "tini", "--", "docker-entrypoint.sh" ]
#
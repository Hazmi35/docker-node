# TAGS: current, latest
# VARIANT: alpine
# PLATFORMS: linux/amd64, linux/arm64/v8, linux/s390x
FROM docker.io/library/node:25.4.0-alpine@sha256:d1cdf008963e1627f47c4426c33481e538190300ad2514e9f8d5c75755888521

# Set workdir
WORKDIR /app

# Preinstalled packages
RUN apk add --no-cache \
    tini \
    tzdata

ENTRYPOINT [ "tini", "--", "docker-entrypoint.sh" ]

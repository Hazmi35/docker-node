# TAGS: iron, oldlts
# VARIANT:
# PLATFORMS: linux/amd64, linux/arm64/v8, linux/arm/v7, linux/ppc64le, linux/s390x
FROM docker.io/library/node:20.19.3-slim

# Set workdir
WORKDIR /app

# Preinstalled packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        iputils-ping \
        procps \
        tini \
        tzdata \
        ca-certificates \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT [ "tini", "--", "docker-entrypoint.sh" ]
#
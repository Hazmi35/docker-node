# TAGS: fermium
# VARIANT:
# PLATFORMS: linux/amd64, linux/arm64/v8, linux/arm/v7, linux/ppc64le, s390x
FROM docker.io/library/node:14.20.1-bullseye-slim

# Set workdir.
WORKDIR /app

# Preinstalled packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        iputils-ping \
        procps \
        tini \
        tzdata \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/*

# Set entrypoint to use tini init
ENTRYPOINT [ "tini", "--", "docker-entrypoint.sh" ]

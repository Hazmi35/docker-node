# TAGS: jod
# VARIANT:
# PLATFORMS: linux/amd64, linux/arm64/v8, linux/arm/v7, linux/ppc64le, linux/s390x
FROM docker.io/library/node:22.22.0-slim@sha256:f86be15afa9a8277608e141ce2a8aa55d3d9c40845921b8511f4fb7897be2554

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

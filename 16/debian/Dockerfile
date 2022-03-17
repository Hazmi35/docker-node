# TAGS: gallium, lts
# VARIANT:
# PLATFORMS: linux/amd64, linux/arm64/v8, linux/arm/v7, linux/ppc64le, linux/s390x
FROM node:16.14.1-bullseye-slim

# Set workdir
WORKDIR /app

# Preinstalled packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    tzdata \
    procps \
    iputils-ping \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/*

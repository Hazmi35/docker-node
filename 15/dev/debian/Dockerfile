# TAGS: 15-historic
# VARIANT: dev
# PLATFORMS: linux/amd64, linux/arm64/v8, linux/arm/v7, linux/ppc64le, s390x
FROM docker.io/library/node:18.4.0-buster-slim

# Set workdir
WORKDIR /tmp/build

# Install node-gyp dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        git \
        python3 \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && ln -sf /usr/bin/python3 /usr/local/bin/python \
    && rm -rf /var/lib/apt/lists/*

# Set jobs to max in npm global config
RUN npm config set jobs max --global

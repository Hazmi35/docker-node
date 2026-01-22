# TAGS: lts, krypton
# VARIANT: dev
# PLATFORMS: linux/amd64, linux/arm64/v8, linux/ppc64le, linux/s390x
FROM docker.io/library/node:24.13.0-slim@sha256:bf22df20270b654c4e9da59d8d4a3516cce6ba2852e159b27288d645b7a7eedc

# Set workdir
WORKDIR /tmp/build

# Install node-gyp dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        git \
        python3 python-is-python3 \
        tini \
        ca-certificates \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/*

# Set jobs to max in npm global config
RUN mkdir -p /usr/local/etc \
    && touch /usr/local/etc/npmrc \
    && echo "jobs=max" >> /usr/local/etc/npmrc

ENTRYPOINT [ "tini", "--", "docker-entrypoint.sh" ]

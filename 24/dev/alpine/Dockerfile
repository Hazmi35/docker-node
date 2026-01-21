# TAGS: lts, krypton
# VARIANT: dev-alpine
# PLATFORMS: linux/amd64, linux/arm64/v8, linux/s390x
FROM docker.io/library/node:24.13.0-alpine@sha256:931d7d57f8c1fd0e2179dbff7cc7da4c9dd100998bc2b32afc85142d8efbc213

# Set workdir
WORKDIR /tmp/build

# Install node-gyp dependencies
RUN apk add --no-cache \
    build-base \
    git \
    python3 \
    tini

# Link python to python3
RUN ln -s /usr/bin/python3 /usr/local/bin/python

# Set jobs to max in npm global config
RUN mkdir -p /usr/local/etc \
    && touch /usr/local/etc/npmrc \
    && echo "jobs=max" >> /usr/local/etc/npmrc

ENTRYPOINT [ "tini", "--", "docker-entrypoint.sh" ]

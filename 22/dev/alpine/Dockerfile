# TAGS: jod
# VARIANT: dev-alpine
# PLATFORMS: linux/amd64, linux/arm64/v8, linux/arm/v7, linux/arm/v6, linux/s390x
FROM docker.io/library/node:22.22.0-alpine@sha256:a9cd9bac76cf2396abf14ff0d1c3671a8175fe577ce350e62ab0fc1678050176

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

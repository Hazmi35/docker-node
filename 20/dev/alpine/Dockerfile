# TAGS: iron, current, latest
# VARIANT: dev-alpine
<<<<<<< HEAD
# PLATFORMS: linux/amd64, linux/arm64/v8, linux/arm/v7, linux/arm/v6, linux/ppc64le
FROM docker.io/library/node:20.5.0-alpine
=======
# PLATFORMS: linux/amd64, linux/arm64/v8, linux/arm/v7, linux/arm/v6, linux/ppc64le, linux/s390x
FROM docker.io/library/node:20.3.1-alpine
>>>>>>> 20b4ac2 (revert: chore: remove s390x temporarily)

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

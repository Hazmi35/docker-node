# TAGS: iron, oldlts
# VARIANT: dev-alpine
# PLATFORMS: linux/amd64, linux/arm64/v8, linux/arm/v7, linux/arm/v6, linux/ppc64le, linux/s390x
FROM docker.io/library/node:20.20.0-alpine@sha256:09e2b3d9726018aecf269bd35325f46bf75046a643a66d28360ec71132750ec8

# Set working directory for builds
WORKDIR /tmp/build

# Install development dependencies and build tools
RUN apk add --no-cache \
    build-base \
    git \
    python3 \
    py3-pip \
    tini && \
    # Create python symlink for compatibility
    ln -sf /usr/bin/python3 /usr/local/bin/python && \
    # Clean up package cache
    rm -rf /var/cache/apk/*

# Configure npm for optimal build performance
RUN mkdir -p /usr/local/etc && \
    echo "jobs=max" > /usr/local/etc/npmrc && \
    echo "fund=false" >> /usr/local/etc/npmrc

# Use tini as entrypoint for proper signal handling
ENTRYPOINT ["tini", "--", "docker-entrypoint.sh"]

# Default command
CMD ["node"]

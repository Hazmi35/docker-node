# TAGS: current, latest
# VARIANT: dev-alpine
# PLATFORMS: linux/amd64, linux/arm64/v8, linux/s390x
FROM docker.io/library/node:25.5.0-alpine@sha256:f741690269ee7abb07675cb744f0b66ec117b482d89d9565a36f2360d5e2a3ef

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

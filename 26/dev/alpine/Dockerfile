# TAGS: current, latest
# VARIANT: dev-alpine
# PLATFORMS: linux/amd64, linux/arm64/v8
FROM docker.io/library/node:26.13.0-alpine@sha256:8996bb5821d62a8fd9bb27c1cb07462f3fdce6e47d640c6a881ead0b064ce216

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

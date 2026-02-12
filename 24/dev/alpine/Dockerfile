# TAGS: lts, krypton
# VARIANT: dev-alpine
# PLATFORMS: linux/amd64, linux/arm64/v8, linux/s390x
FROM docker.io/library/node:24.13.1-alpine@sha256:4f696fbf39f383c1e486030ba6b289a5d9af541642fc78ab197e584a113b9c03

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

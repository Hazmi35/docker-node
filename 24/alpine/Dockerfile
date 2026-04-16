# TAGS: lts, krypton
# VARIANT: alpine
# PLATFORMS: linux/amd64, linux/arm64/v8, linux/s390x
FROM docker.io/library/node:24.14.1-alpine@sha256:8510330d3eb72c804231a834b1a8ebb55cb3796c3e4431297a24d246b8add4d5

# Set working directory
WORKDIR /app

# Install essential packages
RUN apk add --no-cache \
    tini \
    tzdata && \
    # Clean up package cache
    rm -rf /var/cache/apk/*

# Use tini as entrypoint for proper signal handling
ENTRYPOINT ["tini", "--", "docker-entrypoint.sh"]

# Default command
CMD ["node"]

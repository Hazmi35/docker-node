# TAGS: jod
# VARIANT: alpine
# PLATFORMS: linux/amd64, linux/arm64/v8, linux/arm/v7, linux/arm/v6, linux/s390x
FROM docker.io/library/node:22.23.5-alpine@sha256:1314fb30ec37592d5845e5a160d522c0e680972aa534549940b8d73bde88481a

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

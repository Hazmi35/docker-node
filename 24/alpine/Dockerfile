# TAGS: lts, krypton
# VARIANT: alpine
# PLATFORMS: linux/amd64, linux/arm64/v8, linux/s390x
FROM docker.io/library/node:24.19.0-alpine@sha256:d32cdf619f63fe0471182d08996dd516c6275bb5fd31ae06e55a570bd9e1ad43

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

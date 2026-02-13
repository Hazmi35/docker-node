# TAGS: current, latest
# VARIANT: alpine
# PLATFORMS: linux/amd64, linux/arm64/v8, linux/s390x
FROM docker.io/library/node:25.6.1-alpine@sha256:b9b5737eabd423ba73b21fe2e82332c0656d571daf1ebf19b0f89d0dd0d3ca93


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

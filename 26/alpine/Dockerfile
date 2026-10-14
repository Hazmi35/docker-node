# TAGS: current, latest
# VARIANT: alpine
# PLATFORMS: linux/amd64, linux/arm64/v8
FROM docker.io/library/node:26.12.0-alpine@sha256:6f08a523443ddedf52941874c203475b0ad503e859ad70cb26ab8be9a517dbd5


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

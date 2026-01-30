# TAGS: current, latest
# VARIANT:
# PLATFORMS: linux/amd64, linux/arm64/v8, linux/ppc64le, linux/s390x
FROM docker.io/library/node:25.5.0-slim@sha256:ec5e27581e578ec3d25b81f4d9f9088fc2efa3087a78d1bf278f051db67c5b5b

# Set working directory
WORKDIR /app

# Install essential packages and clean up in a single layer
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        iputils-ping \
        procps \
        tini \
        tzdata && \
    # Clean up apt cache and temporary files
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false && \
    apt-get autoremove -y && \
    apt-get autoclean -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Use tini as entrypoint for proper signal handling
ENTRYPOINT ["tini", "--", "docker-entrypoint.sh"]

# Default command
CMD ["node"]

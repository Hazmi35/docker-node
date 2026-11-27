# TAGS: jod
# VARIANT:
# PLATFORMS: linux/amd64, linux/arm64/v8, linux/arm/v7, linux/ppc64le
FROM docker.io/library/node:22.23.5-slim@sha256:be979e5523c76fa4d5ca4ebd3099078f220aa47ec39c48ad5b5df9314debd6eb

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

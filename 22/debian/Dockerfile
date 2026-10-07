# TAGS: jod, oldlts
# VARIANT:
# PLATFORMS: linux/amd64, linux/arm64/v8, linux/arm/v7, linux/ppc64le
FROM docker.io/library/node:22.23.3-slim@sha256:c3de60bf2f9dd0ac6370e6117950ff62d6e339527e7472301c9c78a017978392

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

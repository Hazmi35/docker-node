# TAGS: jod, oldlts
# VARIANT: dev
# PLATFORMS: linux/amd64, linux/arm64/v8, linux/arm/v7, linux/ppc64le
FROM docker.io/library/node:22.23.2-slim@sha256:48e4b67d85f87bd551df43704e24d252f56cc5f8e9718841aace50f19948f0f9

# Set working directory for builds
WORKDIR /tmp/build

# Install development dependencies and build tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        ca-certificates \
        git \
        python3 \
        python3-pip \
        python-is-python3 \
        tini && \
    # Clean up apt cache and temporary files
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false && \
    apt-get autoremove -y && \
    apt-get autoclean -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Configure npm for optimal build performance
RUN mkdir -p /usr/local/etc && \
    echo "jobs=max" > /usr/local/etc/npmrc && \
    echo "fund=false" >> /usr/local/etc/npmrc

# Use tini as entrypoint for proper signal handling
ENTRYPOINT ["tini", "--", "docker-entrypoint.sh"]

# Default command
CMD ["node"]

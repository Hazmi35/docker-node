# TAGS: current, latest
# VARIANT: dev
# PLATFORMS: linux/amd64, linux/arm64/v8, linux/ppc64le, linux/s390x
FROM docker.io/library/node:25.6.1-slim@sha256:32f45869cf02c26971de72c383d5f99cab002905ed8b515b56df925007941782

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

FROM node:17.1.0-slim

# Set workdir
WORKDIR /tmp/build

# Install node-gyp dependencies
RUN apt-get update \
    && apt-get install -y build-essential git python3 python-is-python3 \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/*

# Set jobs to max in npm global config
RUN npm config set jobs max --global

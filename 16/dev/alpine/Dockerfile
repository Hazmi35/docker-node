FROM node:16.13.1-alpine

# Set workdir
WORKDIR /tmp/build

# Install node-gyp dependencies
RUN apk add --no-cache build-base git python3

# Link python to python3
RUN ln -s /usr/bin/python3 /usr/local/bin/python

# Set jobs to max in npm global config
RUN npm config set jobs max --global

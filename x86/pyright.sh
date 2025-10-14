#!/bin/bash
set -ev

pushd /tmp

# nodejs
NODE_VERSION=${VERSION:-22.14.0}
curl -LO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-arm64.tar.xz"

tar -xf node-v$NODE_VERSION-linux-arm64.tar.xz

# Create directory
mkdir -p $HOME/.local/src

# Remove
rm -rf $HOME/.local/node || true

mv node-v$NODE_VERSION-linux-arm64 $HOME/.local/node

# pyright
PATH=$HOME/.local/node/bin:$PATH $HOME/.local/node/bin/npm install -g pyright

popd

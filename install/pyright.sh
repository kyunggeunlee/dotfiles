#!/bin/bash
set -ev

pushd /tmp

# nodejs
NODE_VERSION=${VERSION:-14.17.6}
curl -LO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz"

tar -xf node-v$NODE_VERSION-linux-x64.tar.xz

# Create directory
mkdir -p $HOME/.local/src

# Remove
rm -rf $HOME/.local/node || true

mv node-v$NODE_VERSION-linux-x64 $HOME/.local/node

# pyright
$HOME/.local/node/bin/npm install -g pyright

popd

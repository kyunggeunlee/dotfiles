#!/bin/bash
set -ev

INSTALL_PATH=$HOME/.local/lib/node
BIN_PATH=$HOME/.local/bin

# Create directories
mkdir -p $INSTALL_PATH
mkdir -p $BIN_PATH

# Remove
rm -f $BIN_PATH/pyright                   || true
rm -f $BIN_PATH/pyright-langserver        || true
rm -rf $INSTALL_PATH/node_modules/pyright || true

# Install
npm install --prefix $INSTALL_PATH pyright

# Link
ln -s $INSTALL_PATH/node_modules/pyright/index.js $BIN_PATH/pyright
ln -s $INSTALL_PATH/node_modules/pyright/langserver.index.js $BIN_PATH/pyright-langserver

#!/bin/bash

INSTALL_PATH=$HOME/.local/lib/node
BIN_PATH=$HOME/.local/bin

mkdir -p $INSTALL_PATH
mkdir -p $BIN_PATH

rm -f $BIN_PATH/pyright
rm -f $BIN_PATH/pyright-langserver
rm -rf $INSTALL_PATH/node_modules/pyright

npm install --prefix $INSTALL_PATH pyright

ln -s $INSTALL_PATH/node_modules/pyright/index.js $BIN_PATH/pyright
ln -s $INSTALL_PATH/node_modules/pyright/langserver.index.js $BIN_PATH/pyright-langserver

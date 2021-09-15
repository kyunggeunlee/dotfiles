#!/bin/bash

sudo apt update && sudo apt install -y libevent-dev

# tmux
VERSION=${VERSION:-3.2a}
rm $HOME/.local/bin/tmux
cd /tmp
wget https://github.com/tmux/tmux/releases/download/$VERSION/tmux-$VERSION.tar.gz
tar -xvf tmux-$VERSION.tar.gz
cd tmux-$VERSION
mkdir -p $HOME/.local/bin
./configure --prefix=$HOME/.local
make && make install

# tpm
git clone --depth=1 https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
$HOME/.tmux/plugins/tpm/bin/install_plugins

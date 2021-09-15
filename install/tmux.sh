#!/bin/bash
set -ev

sudo apt update && sudo apt install -y libevent-dev

# tmux
TMUX_VERSION=${VERSION:-3.2a}
pushd /tmp
wget https://github.com/tmux/tmux/releases/download/$TMUX_VERSION/tmux-$TMUX_VERSION.tar.gz
tar -xvf tmux-$TMUX_VERSION.tar.gz
pushd tmux-$TMUX_VERSION
mkdir -p $HOME/.local/bin
rm $HOME/.local/bin/tmux || true
./configure --prefix=$HOME/.local
make && make install
popd

# tpm
git clone --depth=1 https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
$HOME/.tmux/plugins/tpm/bin/install_plugins
popd

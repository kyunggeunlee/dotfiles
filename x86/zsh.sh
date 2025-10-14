#!/bin/bash
set -ev

sudo apt update && sudo apt install -y libncurses5-dev libncursesw5-dev curl

pushd /tmp

# zsh
ZSH_VERSION=${VERSION:-5.8}
wget https://sourceforge.net/projects/zsh/files/zsh/$ZSH_VERSION/zsh-$ZSH_VERSION.tar.xz
tar -xvf zsh-$ZSH_VERSION.tar.xz
pushd zsh-$ZSH_VERSION
mkdir -p $HOME/.local
rm -rf $HOME/.local/bin/zsh $HOME/.local/bin/zsh-*.* $HOME/.local/lib/zsh $HOME/.local/share/zsh || true
./configure --prefix=$HOME/.local
make && make install
popd

# oh-my-zsh
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions

popd

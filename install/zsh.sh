#!/bin/bash

sudo apt update && sudo apt install -y libncurses5-dev libncursesw5-dev

# zsh
VERSION=${VERSION:-5.8}
rm -rf $HOME/.local/bin/zsh $HOME/.local/bin/zsh-*.* $HOME/.local/lib/zsh $HOME/.local/share/zsh
cd /tmp
wget https://sourceforge.net/projects/zsh/files/zsh/$VERSION/zsh-$VERSION.tar.xz
tar -xvf zsh-$VERSION.tar.xz
cd zsh-$VERSION
mkdir -p $HOME/.local
./configure --prefix=$HOME/.local
make && make install

# oh-my-zsh
cd /tmp
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
source $HOME/.zshrc

# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

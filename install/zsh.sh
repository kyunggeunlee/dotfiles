#!/bin/bash

# zsh
sudo apt install -y zsh
chsh -s `which zsh`

# oh-my-zsh
cd /tmp
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

# zsh-autosuggestions
zsh -c "git clone https://github.com/zsh-users/zsh-autosuggestions $(echo $ZSH_CUSTOM)/plugins/zsh-autosuggestions"

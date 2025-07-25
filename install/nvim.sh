#!/bin/bash
set -ev

pushd /tmp

curl -LO https://github.com/neovim/neovim/releases/download/v0.10.4/nvim-linux-x86_64.tar.gz
tar xzf nvim-linux-x86_64.tar.gz
mkdir -p ~/.local

# Remove
rm -f ~/.local/bin/nvim    || true
rm -rf ~/.local/lib/nvim   || true
rm -rf ~/.local/share/nvim || true

# Install nvim
rsync -rltoD nvim-linux-x86_64/* ~/.local/

# Install plugins
sh -c 'curl -fLo "$HOME/.local/share/nvim/site/autoload/plug.vim" --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
$HOME/.local/bin/nvim -E -s -u ~/.config/nvim/init.vim +PlugInstall +qall!

popd

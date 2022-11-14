#!/bin/bash
set -ev

pushd /tmp

# Get nightly release
curl -LO https://github.com/neovim/neovim/releases/download/v0.7.0/nvim-linux64.tar.gz
tar xzf nvim-linux64.tar.gz
mkdir -p ~/.local

# Remove
rm -f ~/.local/bin/nvim    || true
rm -rf ~/.local/lib/nvim   || true
rm -rf ~/.local/share/nvim || true

# Install nvim
rsync -rltoD nvim-linux64/* ~/.local/

# Install plugins
sh -c 'curl -fLo "$HOME/.local/share/nvim/site/autoload/plug.vim" --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
$HOME/.local/bin/nvim -E -s -u ~/.config/nvim/init.vim +PlugInstall +qall!

popd

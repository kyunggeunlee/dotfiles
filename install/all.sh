#!/bin/bash
set -ev

DIRNAME=$(dirname $(readlink -f "$0"))

source $DIRNAME/zsh.sh
source $DIRNAME/tmux.sh
source $DIRNAME/nodejs.sh
source $DIRNAME/pyright.sh
source $DIRNAME/nvim-nightly.sh
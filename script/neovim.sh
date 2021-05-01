#!/bin/bash
set -e

export PYTHONPATH=python3:pip3
pip3 install pynvim

# neovim-remote
pip3 install neovim-remote

# vim
# curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > ./installer.sh
# mkdir -p $HOME/.config/nvim
# sh ./installer.sh ~/.config/nvim/. ; rm ./installer.sh

exit 0

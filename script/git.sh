#!/bin/bash
set -e

# git
git config --global core.editor 'nvr'
git config --global user.name "mitubaEX"
git config --global user.email "g1344955@cse.kyoto-su.ac.jp"

# gitignore global
ln -sf $(pwd)/.gitignore_global $HOME/.gitignore_global
git config --global core.excludesfile $HOME/.gitignore_global

mkdir $HOME/.ghq
export GOPATH=$HOME/.ghq

# ghq
go get -u github.com/motemen/ghq

echo '[ghq]' >> $HOME/.gitconfig
echo '    root = ~/.ghq/src' >> $HOME/.gitconfig

# diff-highlight
# https://udomomo.hatenablog.com/entry/2019/12/01/181404
echo '[pager]' >> $HOME/.gitconfig
echo '  log = diff-highlight | less' >> $HOME/.gitconfig
echo '  show = diff-highlight | less' >> $HOME/.gitconfig
echo '  diff = diff-highlight | less' >> $HOME/.gitconfig

sudo ln -s /usr/local/share/git-core/contrib/diff-highlight/diff-highlight /usr/local/bin/diff-highlight

exit 0

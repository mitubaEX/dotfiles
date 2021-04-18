#!/bin/bash
set -ex

# homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# yabai
brew install koekeishiya/formulae/yabai
# Please change permission for mac
# ref: https://github.com/koekeishiya/yabai/wiki/Installing-yabai-(latest-release)#macos-big-sur---automatically-load-scripting-addition-on-startup
# sudo yabai --install-sa

# khd
brew install koekeishiya/formulae/skhd

brew install fzf
brew install zsh
brew install neovim
brew install tree
brew install wget
brew install tmux
brew install ag
brew install exa
brew install reattach-to-user-namespace
brew install rust
brew install ripgrep
brew install direnv

# launchctl load
brew services start yabai
brew services start skhd

# fonts
brew tap homebrew/cask-fonts
brew install font-hack-nerd-font --cask

# node
# brew install node

echo 'npm install'
npm install -g neovim
npm install -g typescript
npm install -g javascript-typescript-langserver
npm install -g gitmoji-cli

exit 0

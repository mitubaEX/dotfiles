#!/bin/bash
set -ex

# homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# yabai
brew install koekeishiya/formulae/yabai
sudo yabai --install-sa

# khd
brew install khd
cp /usr/local/opt/chunkwm/share/chunkwm/examples/khdrc ~/.khdrc
brew install skhd

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
brew services start khd
brew services start skhd

# fonts
brew tap homebrew/cask-fonts
brew cask install font-hack-nerd-font

# node
# brew install node

echo 'npm install'
npm install -g neovim
npm install -g typescript
npm install -g javascript-typescript-langserver

exit 0

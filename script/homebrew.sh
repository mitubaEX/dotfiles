# homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# chunkwm
brew tap crisidev/homebrew-chunkwm
brew tap koekeishiya/formulae
brew install --HEAD chunkwm

# khd
brew install khd
cp /usr/local/opt/chunkwm/share/chunkwm/examples/khdrc ~/.khdrc
brew install skhd

brew install python3
brew install fzf
brew install zsh
brew install neovim
brew install tree
brew install wget
brew install tmux
brew install ag
brew install exa
brew install reattach-to-user-namespace
brew install go
brew install rust
brew install ripgrep
brew install direnv

# launchctl load
brew services start chunkwm
brew services start khd
brew services start skhd

# fonts
brew tap homebrew/cask-fonts
brew cask install font-hack-nerd-font

# node
brew install node yarn
npm install -g neovim
npm -g install typescript
yarn add global javascript-typescript-langserver


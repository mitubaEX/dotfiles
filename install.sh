# homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install python3 fzf zsh neovim tree wget tmux caskroom/cask/iterm2 ag exa reattach-to-user-namespace caskroom/versions/java8 gradle go kotlin rust sbt scala caskroom/cask/google-chrome caskroom/cask/slack caskroom/cask/hyperswitch caskroom/cask/amethyst ripgrep ctags

# prezto
cd $HOME
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

export PYTHONPATH=python3:pip3
pip3 install neovim
nvim -e -c "call dein#install()"
nvim -e -c "UpdateRemotePlugins"

# git
git config --global core.editor 'nvr'
git config --global user.name "mitubaEX"
git config --global user.email "g1344955@cse.kyoto-su.ac.jp"

# powerline fonts
# clone
cd $HOME
git clone https://github.com/powerline/fonts.git --depth=1
# install
cd fonts
./install.sh
# clean-up a bit
cd ..
rm -rf fonts

# fonts
brew tap caskroom/fonts
brew cask install font-hack-nerd-font

# tmux
# cd
# git clone https://github.com/gpakosz/.tmux.git
# ln -s -f .tmux/.tmux.conf
# cp .tmux/.tmux.conf.local .

# neovim-remote
pip3 install neovim-remote

mkdir $HOME/.ghq
export GOPATH=$HOME/.ghq

# install gocode
go get -u github.com/mdempsky/gocode

# haskell
stack setup

# vim
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > ./installer.sh
sh ./installer.sh ~/.cache/dein/. ; rm ./installer.sh

# arch linux
if [ "$(uname)" = "Linux" ]; then
  git config --global credential.helper /usr/lib/git-core/git-credential-gnome-keyring
fi


# ghq
go get -u github.com/motemen/ghq

echo '[ghq]' >> $HOME/.gitconfig
echo '    root = ~/.ghq/src' >> $HOME/.gitconfig

# mac config {{{
## mute startup sound
sudo nvram SystemAudioVolume=" "

## not sleep
sudo systemsetup -setcomputersleep Off > /dev/null

## present only opened app on dock
defaults write com.apple.dock static-only -bool true

## remove all app of dock
defaults write com.apple.dock persistent-apps -array

## present dotfiles
defaults write com.apple.finder AppleShowAllFiles -bool true

defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

## skip disk verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

# Show the /Volumes folder
sudo chflags nohidden /Volumes
# }}}

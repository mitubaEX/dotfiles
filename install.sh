# homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# arch linux
if [ "$(uname)" = "Linux" ]; then
  sudo apt-get update
  sudo apt install -y cargo
  sudo apt-get install -y python3 zsh neovim tree wget tmux scala gcc make golang i3 rofi cmake curl libfreetype6-dev libfontconfig1-dev xclip git cmake-data libcairo2-dev libxcb1-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-image0-dev libxcb-randr0-dev libxcb-util0-dev libxcb-xkb-dev pkg-config python-xcbgen xcb-proto libxcb-xrm-dev i3-wm libasound2-dev libmpdclient-dev libiw-dev libcurl4-openssl-dev libpulse-dev libgnome-keyring-dev fcitx-mozc i3lock feh compton gdebi

  # alacritty(install release page)

  # install slack
  # ref: https://qiita.com/akjgskwi/items/a65d396e353e31f235d2

  # exa
  cargo install exa

  # rg
  cargo install ripgrep

  # polybar
  cd $HOME
  git clone https://github.com/jaagr/polybar.git
  cd polybar && ./build.sh

  # keymap config
  sudo dpkg-reconfigure keyboard-configuration

  # neovim
  sudo apt-add-repository ppa:neovim-ppa/stable
  sudo apt-get update
  sudo apt-get install neovim
  sudo apt-get install python-dev python-pip python3-dev python3-pip
  pip3 install pynvim

  # fzf install
  cd $HOME
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install

  # brightness controller
  sudo add-apt-repository ppa:apandada1/brightness-controller
  sudo apt-get update
  sudo apt-get install brightness-controller

  # docker
  cd $HOME
  sudo apt-get update
  sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo apt-key fingerprint 0EBFCD88
  sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"
  sudo apt-get update
  sudo apt-get install -y docker-ce

  # docker-compose
  sudo curl -L "https://github.com/docker/compose/releases/download/1.12.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose

  # discord
  sudo apt install snapd-xdg-open
  sudo snap install discord

  # slack
  sudo apt install snapd
  sudo snap install slack --classic

  # dep
  curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh

  # download desktop image
  cd $HOME
  wget https://pbs.twimg.com/media/DaYXBsTVAAElEg2.jpg

  # remove sudo of docker command
  # ref: https://qiita.com/DQNEO/items/da5df074c48b012152ee
  sudo groupadd docker
  sudo gpasswd -a $USER docker
  sudo systemctl restart docker
else
  brew install python3 fzf zsh neovim tree wget tmux caskroom/cask/iterm2 ag exa reattach-to-user-namespace caskroom/versions/java8 gradle go kotlin rust sbt scala caskroom/cask/google-chrome caskroom/cask/slack caskroom/cask/hyperswitch caskroom/cask/amethyst ripgrep ctags
fi

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
  cd /usr/share/doc/git/contrib/credential/gnome-keyring
  sudo make
  git config --global credential.helper /usr/share/doc/git/contrib/credential/gnome-keyring/git-credential-gnome-keyring
  cd $HOME
fi


# ghq
go get -u github.com/motemen/ghq

echo '[ghq]' >> $HOME/.gitconfig
echo '    root = ~/.ghq/src' >> $HOME/.gitconfig

mkdir -p ~/.zsh/completion
curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/zsh/_docker-compose > ~/.zsh/completion/_docker-compose

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

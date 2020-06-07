#!/bin/bash

# for ubuntu
if [ "$(uname)" = "Linux" ]; then
  sudo apt-get update
  sudo apt install -y cargo
  sudo apt-get install -y python3 zsh neovim tree wget tmux scala gcc make golang i3 rofi cmake curl libfreetype6-dev libfontconfig1-dev xclip git cmake-data libcairo2-dev libxcb1-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-image0-dev libxcb-randr0-dev libxcb-util0-dev libxcb-xkb-dev pkg-config python-xcbgen xcb-proto libxcb-xrm-dev i3-wm libasound2-dev libmpdclient-dev libiw-dev libcurl4-openssl-dev libpulse-dev libgnome-keyring-dev fcitx-mozc i3lock feh compton gdebi binutils-avr gcc-avr avr-libc avrdude conky libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf xutils-dev libtool postfix

  # alacritty(install release page)

  # install slack
  # ref: https://qiita.com/akjgskwi/items/a65d396e353e31f235d2

  # exa
  cargo install exa

  # rg
  cargo install ripgrep

  # fd
  cargo install fd-find

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
  sudo chmod 660 /dev/tty

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

  # gaps
  cd $HOME
  mkdir tmp
  cd /tmp
  git clone https://github.com/Airblader/xcb-util-xrm
  cd xcb-util-xrm
  git submodule update --init
  ./autogen.sh --prefix=/usr
  make
  sudo make install

  cd /tmp
  git clone https://www.github.com/Airblader/i3 i3-gaps
  cd i3-gaps
  git checkout gaps && git pull
  autoreconf --force --install
  rm -rf build
  mkdir build
  cd build
  ../configure --prefix=/usr --sysconfdir=/etc
  make
  sudo make install
else
  chmod +x ./script/homebrew.sh
  sh ./script/homebrew.sh

  chmod +x ./script/homebrew.sh
  sh ./script/git.sh

  chmod +x ./script/homebrew.sh
  sh ./script/neovim.sh

  chmod +x ./script/mac_config.sh
  sh ./script/mac_config.sh

  chmod +x ./script/zsh.sh
  sh ./script/zsh.sh
fi

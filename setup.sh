# dein
mkdir -p $HOME/plugins
find plugins -type f | xargs -I% ln -sf $(pwd)/% $HOME/%

# .config
mkdir -p $HOME/.config
mkdir -p $HOME/.config/alacritty
mkdir -p $HOME/.config/i3
mkdir -p $HOME/.config/oni
mkdir -p $HOME/.config/solargraph

# tmux
ln -sf $(pwd)/tmux/.tmux.conf $HOME/.tmux.conf
ln -sf $(pwd)/tmux/tmuxline.conf $HOME/.tmuxline.conf

ln -sf $(pwd)/.xintrc $HOME/.xintrc
ln -sf $(pwd)/.xprofile $HOME/.xprofile

# amethyst config
ln -sf $(pwd)/com.amethyst.Amethyst.plist $HOME/Library/Preferences/com.amethyst.Amethyst.plist

# aquaskk
mkdir -p $HOME/Library/Application Support/AquaSKK
ln -sf $(pwd)/AquaSKK/keymap.conf "$HOME/Library/Application Support/AquaSKK/keymap.conf"
ln -sf $(pwd)/AquaSKK/kana-rule.conf "$HOME/Library/Application Support/AquaSKK/kana-rule.conf"

# intelij
ln -sf $(pwd)/.ideavimrc $HOME/.ideavimrc

ln -sf $(pwd)/.profile $HOME/.profile

# vscode
if [ "$(uname)" = "Linux" ]; then
  ln -sf $(pwd)/.config/Code/User/settings.json $HOME/.config/Code/User/.
  ln -sf $(pwd)/.config/Code/User/keybindings.json $HOME/.config/Code/User/.
else
  ln -sf $(pwd)/.config/Code/User/settings.json $HOME/Library/Application\ Support/Code/User/.
  ln -sf $(pwd)/.config/Code/User/keybindings.json $HOME/Library/Application\ Support/Code/User/.
fi

# conky
mkdir -p $HOME/bin
ln -sf $(pwd)/.conkyrc $HOME/.conkyrc
ln -sf $(pwd)/bin/conky-i3bar $HOME/bin/conky-i3bar

# yabai
ln -sf $(pwd)/.yabairc $HOME/.yabairc
ln -sf $(pwd)/.khdrc $HOME/.skhdrc

# .env
ln -sf $(pwd)/.env $HOME/.env

# crefre
ln -sf $(pwd)/crefre.zsh $HOME/crefre.zsh

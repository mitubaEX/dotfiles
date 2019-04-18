mkdir $HOME/.config

ln -sf $(pwd)/dein.toml $HOME/dein.toml

# nvim
mkdir $HOME/.config/nvim
ln -sf $(pwd)/.config/nvim/init.vim $HOME/.config/nvim/init.vim
mkdir $HOME/.config/nvim/config
ln -sf $(pwd)/.config/nvim/config/dein_script.vimrc $HOME/.config/nvim/config/dein_script.vimrc
ln -sf $(pwd)/.config/nvim/config/keybinds.vimrc $HOME/.config/nvim/config/keybinds.vimrc
ln -sf $(pwd)/.config/nvim/config/set.vimrc $HOME/.config/nvim/config/set.vimrc
ln -sf $(pwd)/.config/nvim/config/lsp.vimrc $HOME/.config/nvim/config/lsp.vimrc


ln -sf $(pwd)/.zshrc $HOME/.zshrc
ln -sf $(pwd)/.zpreztorc $HOME/.zpreztorc
ln -sf $(pwd)/tmux/.tmux.conf $HOME/.tmux.conf

mkdir $HOME/.config/alacritty
ln -sf $(pwd)/.config/alacritty/alacritty.yml $HOME/.config/alacritty/alacritty.yml

mkdir $HOME/.config/i3
ln -sf $(pwd)/.config/i3/config $HOME/.config/i3/config

ln -sf $(pwd)/.xintrc $HOME/.xintrc
ln -sf $(pwd)/.xprofile $HOME/.xprofile

# amethyst config
ln -sf $(pwd)/com.amethyst.Amethyst.plist $HOME/Library/Preferences/com.amethyst.Amethyst.plist

# aquaskk
mkdir $HOME/Library/Application Support/AquaSKK
ln -sf $(pwd)/keymap.conf "$HOME/Library/Application Support/AquaSKK/keymap.conf"

# oni
mkdir $HOME/.config/oni
ln -sf $(pwd)/.config/oni/config.js $HOME/.config/oni/config.js

ln -sf $(pwd)/.ideavimrc $HOME/.ideavimrc

ln -sf $(pwd)/.profile $HOME/.profile

# vscode
if [ "$(uname)" = "Linux" ]; then
  ln -sf $(pwd)/.config/Code/User/settings.json $HOME/.config/Code/User/.
else
  ln -sf $(pwd)/.config/Code/User/settings.json $HOME/Library/Application\ Support/Code/User/.
fi

# conky
mkdir $HOME/bin
ln -sf $(pwd)/.conkyrc $HOME/.conkyrc
ln -sf $(pwd)/bin/conky-i3bar $HOME/bin/conky-i3bar

# chunkwm
ln -sf $(pwd)/.chunkwmrc $HOME/.chunkwmrc
ln -sf $(pwd)/.khdrc $HOME/.khdrc

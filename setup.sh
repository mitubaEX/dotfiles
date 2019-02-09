mkdir $HOME/.config

ln -sf $(pwd)/dein.toml $HOME/dein.toml

mkdir $HOME/.config/nvim
ln -sf $(pwd)/.config/nvim/init.vim $HOME/.config/nvim/init.vim

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

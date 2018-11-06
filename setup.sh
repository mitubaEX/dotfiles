mkdir $HOME/.config

ln -sf $(pwd)/dein.toml $HOME/dein.toml

mkdir $HOME/.config/nvim
ln -sf $(pwd)/init.vim $HOME/.config/nvim/init.vim

ln -sf $(pwd)/.zshrc $HOME/.zshrc
ln -sf $(pwd)/.zpreztorc $HOME/.zpreztorc
ln -sf $(pwd)/tmux/.tmux.conf $HOME/.tmux.conf

mkdir $HOME/.config/alacritty
ln -sf $(pwd)/alacritty.yml $HOME/.config/alacritty/alacritty.yml

mkdir $HOME/.config/i3
ln -sf $(pwd)/config $HOME/.config/i3/config

ln -sf $(pwd)/.xintrc $HOME/.xintrc
ln -sf $(pwd)/.xprofile $HOME/.xprofile

# amethyst config
ln -sf $(pwd)/com.amethyst.Amethyst.plist $HOME/Library/Preferences/com.amethyst.Amethyst.plist

ln -sf $(pwd)/dein.toml $HOME/dein.toml
ln -sf $(pwd)/init.vim $HOME/.config/nvim/init.vim
ln -sf $(pwd)/.zshrc $HOME/.zshrc
ln -sf $(pwd)/.zpreztorc $HOME/.zpreztorc
ln -sf $(pwd)/.tmux.conf.local $HOME/.tmux.conf.local
ln -sf $(pwd)/alacritty.yml $HOME/.config/alacritty/alacritty.yml

mkdir $HOME/.config/i3
ln -sf $(pwd)/config $HOME/.config/i3/config

ln -sf $(pwd)/.xintrc $HOME/.xintrc
ln -sf $(pwd)/.xprofile $HOME/.xprofile

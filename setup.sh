mkdir -p $HOME/.config

# dein
ln -sf $(pwd)/dein.toml $HOME/dein.toml
ln -sf $(pwd)/dein_lang.toml $HOME/dein_lang.toml
ln -sf $(pwd)/dein_lazy.toml $HOME/dein_lazy.toml
ln -sf $(pwd)/dein_denite.toml $HOME/dein_denite.toml

# nvim
mkdir -p $HOME/.config/nvim
ln -sf $(pwd)/.config/nvim/init.vim $HOME/.config/nvim/init.vim
mkdir -p $HOME/.config/nvim/config
ln -sf $(pwd)/.config/nvim/config/dein_script.vimrc $HOME/.config/nvim/config/dein_script.vimrc
ln -sf $(pwd)/.config/nvim/config/keybinds.vimrc $HOME/.config/nvim/config/keybinds.vimrc
ln -sf $(pwd)/.config/nvim/config/set.vimrc $HOME/.config/nvim/config/set.vimrc
ln -sf $(pwd)/.config/nvim/config/lsp.vimrc $HOME/.config/nvim/config/lsp.vimrc
ln -sf $(pwd)/.config/nvim/config/fzf_functions.vimrc $HOME/.config/nvim/config/fzf_functions.vimrc
ln -sf $(pwd)/.config/nvim/config/coc.vimrc $HOME/.config/nvim/config/coc.vimrc
ln -sf $(pwd)/.config/nvim/config/util_script.vimrc $HOME/.config/nvim/config/util_script.vimrc
ln -sf $(pwd)/.config/nvim/config/color.vimrc $HOME/.config/nvim/config/color.vimrc

# zsh
mkdir -p $HOME/.zsh.d
ln -sf $(pwd)/.zsh.d/* $HOME/.zsh.d/.
ln -sf $(pwd)/.zsh.d/.zshrc $HOME/.zsh.d/.zshrc
ln -sf $(pwd)/.zsh.d/.zshenv $HOME/.zsh.d/.zshenv
ln -sf $(pwd)/.zsh.d/.zprofile $HOME/.zsh.d/.zprofile
ln -sf $(pwd)/.zshenv $HOME/.zshenv
ln -sf $(pwd)/.zpreztorc $HOME/.zsh.d/.zpreztorc
ln -sf $(pwd)/tmux/.tmux.conf $HOME/.tmux.conf
ln -sf $(pwd)/tmux/tmuxline.conf $HOME/.tmuxline.conf

mkdir -p $HOME/.config/alacritty
ln -sf $(pwd)/.config/alacritty/alacritty.yml $HOME/.config/alacritty/alacritty.yml

mkdir -p $HOME/.config/i3
ln -sf $(pwd)/.config/i3/config $HOME/.config/i3/config

ln -sf $(pwd)/.xintrc $HOME/.xintrc
ln -sf $(pwd)/.xprofile $HOME/.xprofile

# amethyst config
ln -sf $(pwd)/com.amethyst.Amethyst.plist $HOME/Library/Preferences/com.amethyst.Amethyst.plist

# aquaskk
mkdir -p $HOME/Library/Application Support/AquaSKK
ln -sf $(pwd)/AquaSKK/keymap.conf "$HOME/Library/Application Support/AquaSKK/keymap.conf"
ln -sf $(pwd)/AquaSKK/kana-rule.conf "$HOME/Library/Application Support/AquaSKK/kana-rule.conf"

# oni
mkdir -p $HOME/.config/oni
ln -sf $(pwd)/.config/oni/config.js $HOME/.config/oni/config.js

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

# chunkwm
ln -sf $(pwd)/.chunkwmrc $HOME/.chunkwmrc
ln -sf $(pwd)/.khdrc $HOME/.skhdrc

# yabai
ln -sf $(pwd)/.yabairc $HOME/.yabairc

# compton
ln -sf $(pwd)/.config/compton.conf $HOME/.config/compton.conf

# .env
ln -sf $(pwd)/.env $HOME/.env

# template
mkdir -p $HOME/.config/nvim/template
for file in ./.config/nvim/template/* ;do  ln -sf $(pwd)/$file $HOME/$file ;done

# solargraph
mkdir -p $HOME/.config/solargraph
ln -sf $(pwd)/.config/solargraph/config.yml $HOME/.config/solargraph/config.yml

# coc
ln -sf $(pwd)/.config/nvim/coc-settings.json $HOME/.config/nvim/coc-settings.json

# crefre
ln -sf $(pwd)/crefre.zsh $HOME/crefre.zsh

# ultisnips
mkdir -p $HOME/.config/nvim/UltiSnips
ln -sf $(pwd)/.config/nvim/UltiSnips/rspec.snippets $HOME/.config/nvim/UltiSnips/rspec.snippets

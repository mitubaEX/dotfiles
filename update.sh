# homebrew

# yabai
brew upgrade koekeishiya/formulae/yabai

# khd
brew upgrade koekeishiya/formulae/skhd

brew upgrade fzf
brew upgrade zsh
brew upgrade neovim
brew upgrade tree
brew upgrade wget
brew upgrade tmux
brew upgrade tmux-xpanes
brew upgrade ag
brew upgrade exa
brew upgrade reattach-to-user-namespace
brew upgrade ripgrep
brew upgrade direnv

# fonts
brew tap homebrew/cask-fonts
brew cask upgrade font-hack-nerd-font

echo 'npm update'
npm update -g neovim
npm update -g typescript
npm update -g javascript-typescript-langserver

echo 'nvim update'
pip3 install -U pynvim

# neovim-remote
pip3 install -U neovim-remote

exit 0

# direnv
export EDITOR=nvim
eval "$(direnv hook zsh)"

export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"

eval "$(nodenv init -)"
eval "$(rbenv init -)"

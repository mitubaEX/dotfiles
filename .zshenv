# check performance
# zmodload zsh/zprof && zprof

export HISTFILE=${HOME}/.zsh_history
# Appends every command to the history file once it is executed
setopt inc_append_history
# Reloads the history whenever you use it
setopt share_history
export ZDOTDIR=$HOME/.zsh.d
source $ZDOTDIR/.zshenv

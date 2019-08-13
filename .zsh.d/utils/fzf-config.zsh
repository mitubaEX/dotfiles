[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# fzf
if [ "$(uname)" = "Linux" ]; then
  source /usr/share/fzf/key-bindings.zsh
  source /usr/share/fzf/completion.zsh

  if [ -n "$DESKTOP_SESSION" ];then
      eval $(gnome-keyring-daemon --start)
      export SSH_AUTH_SOCK
  fi
fi

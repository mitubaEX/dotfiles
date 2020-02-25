# fzf functions ================= {{{
  # ref: https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh
  # CTRL-R - Paste the selected command from history into the command line
  fzf-history-widget() {
    local selected num
    setopt localoptions noglobsubst noposixbuiltins pipefail 2> /dev/null
    selected=( $(fc -rl 1 |
      FZF_DEFAULT_OPTS="--layout=reverse --height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS --query=${(qqq)LBUFFER} +m" $(__fzfcmd)) )
    local ret=$?
    if [ -n "$selected" ]; then
      num=$selected[1]
      if [ -n "$num" ]; then
        zle vi-fetch-history -n $num
      fi
    fi
    zle reset-prompt
    return $ret
  }
  __fzfcmd() {
    __fzf_use_tmux__ &&
      echo "fzf-tmux -d${FZF_TMUX_HEIGHT:-40%}" || echo "fzf"
  }

  __fzf_use_tmux__() {
    [ -n "$TMUX_PANE" ] && [ "${FZF_TMUX:-0}" != 0 ] && [ ${LINES:-40} -gt 15 ]
  }

  zle     -N   fzf-history-widget
  bindkey '^R' fzf-history-widget

  # ref: https://qiita.com/ssh0/items/a9956a74bff8254a606a
  if [[ ! -n $TMUX ]]; then
    # get the IDs
    ID="`tmux list-sessions`"
    if [[ -z "$ID" ]]; then
      # tmux new-session && exit
      tmux new-session
    fi
    create_new_session="Create New Session"
    ID="$ID\n${create_new_session}:"
    ID="`echo $ID | fzf --height='30%' --layout='reverse'| cut -d: -f1`"
    if [[ "$ID" = "${create_new_session}" ]]; then
      tmux new-session
    elif [[ -n "$ID" ]]; then
      tmux attach-session -t "$ID"
    else
      :  # Start terminal normally
    fi
  fi

  ## ref: https://www.matsub.net/posts/2017/12/01/ghq-fzf-on-tmux
  ## ref: http://blog.chairoi.me/entry/2017/12/26/233926
  function create_session_with_ghq() {
      # rename session if in tmux
      local moveto=$(ghq root)/$(ghq list | fzf --height='30%' --layout='reverse')
      if [[ ! -z ${TMUX} ]]
      then
          local repo_name=`basename $moveto`
          if [ $repo_name != `basename $(ghq root)` ]
          then
            tmux new-session -d -c $moveto -s $repo_name  2> /dev/null
            zle reset-prompt
            tmux switch-client -t $repo_name 2> /dev/null
          else
            zle reset-prompt
          fi
      fi
  }

  zle -N create_session_with_ghq
  bindkey '^G' create_session_with_ghq

  function switch_session_with_fzf() {
      # rename session if in tmux
      local moveto=$(tmux ls | cut -d ':' -f 1 | fzf --height='30%' --layout='reverse')
      if [[ ! -z ${TMUX} ]]
      then
          zle reset-prompt
          tmux switch-client -t $moveto 2> /dev/null
      fi
  }

  zle -N switch_session_with_fzf
  bindkey '^U' switch_session_with_fzf

  # deprecated
  function create_session_with_dir() {
      # rename session if in tmux
      local moveto=$(pwd)/$(find . -type d | fzf --height='30%' --layout='reverse')
      if [[ ! -z ${TMUX} ]]
      then
          local dir_name=`basename $moveto`
          if [ $dir_name != `basename $(pwd)` ]
          then
            tmux new-session -d -c $moveto -s $dir_name  2> /dev/null
            zle reset-prompt
            tmux switch-client -t $dir_name 2> /dev/null
          else
            zle reset-prompt
          fi
      fi
  }

  function remove_session() {
      local session_name=$(tmux display-message -p '#S')
      if [[ ! -z ${TMUX} ]]
      then
          if [ ! -z ${session_name} ]
          then
            tmux switch-client -n
            tmux kill-session -t $session_name 2> /dev/null
          else
            zle reset-prompt
          fi
      fi
  }
  zle -N remove_session
  bindkey '^X' remove_session

  function rename_session() {
    local dir=$(pwd)
    # remove ghq dir
    if [[ $dir != *".ghq"* ]]; then
      local name=$(basename $dir)
      if [[ ! -z ${TMUX} ]]
      then
        if [ ! -z ${name} ]
        then
          tmux rename-session -t $(tmux display-message -p '#S') $name
          # tmux switch-client -t $(echo $moveto | IFS=":" read -r a b; echo $a) 2> /dev/null
        fi
      fi
    fi
  }

  # cdr, add-zsh-hook を有効にする
  autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
  add-zsh-hook chpwd chpwd_recent_dirs

  # fshow - git commit browser
  fshow() {
    git log --graph --color=always \
        --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
    fzf --ansi --no-sort --reverse --tiebreak=index --toggle-sort=\` \
        --bind "ctrl-m:execute:
                  echo '{}' | grep -o '[a-f0-9]\{7\}' | head -1 |
                  xargs -I % sh -c 'git show --color=always % | less -R'"
  }

  zle -N fshow
  bindkey '^O' fshow

  # ref: https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/git/git.plugin.zsh
  # Aliases
  # (sorted alphabetically)
  #

  # export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
  export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'

  # ref: https://dev.classmethod.jp/tool/fzf-original-app-for-git-add/
  function ggaa() {
      local selected
      selected=$(git status -s | fzf -m --ansi --preview="echo {} | awk '{print \$2}' | xargs git diff --color" | awk '{print $2}')
      if [[ -n "$selected" ]]; then
          selected=$(tr '\n' ' ' <<< "$selected")
          git add $(echo $selected | awk '{sub(/.$/,""); print}')
      fi
  }

  function dexec() {
      local selected
      selected=$(docker ps --format "table {{.ID}} {{.Names}}" | sed '1d' | fzf --ansi --height='30%')
      if [[ -n "$selected" ]]; then
        docker exec  -it $(awk '{print $1}' <<< $selected) $@
      fi
  }

  function drm() {
      local selected
      selected=$(docker ps -a --format "table {{.ID}} {{.Names}}" | sed '1d' | fzf -m --ansi --height='30%')
      if [[ -n "$selected" ]]; then
        docker rm -f $(awk '{print $1}' <<< $selected) $@
      fi
  }

# }}}


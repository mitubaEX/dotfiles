alias tmux='tmux -u'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# no check uppper case and lower case
zstyle ':completion:*' matcher-list 'm:{}a-z}={}A-Z}'

# remove duplication of history
setopt hist_ignore_all_dups

# use dir stack
setopt auto_pushd

# remove duplication of dir stack
setopt pushd_ignore_dups

# no-beep
setopt no_beep

# key-bind
bindkey -M viins 'jj' vi-cmd-mode
bindkey -v '^L'   forward-char
bindkey -v '^H'   backward-char
bindkey -v '^K'   up-line-or-history
bindkey -v '^J'   down-line-or-history

# alias
alias e='exit'
alias rm='rm -rf'
alias vi='nvim'
alias vim='nvim'
alias dockerrm='docker rm -f $(docker ps -qa)'
alias dockerrmi='docker rmi -f $(docker images -q)'
alias atmkdir='for i in A B C D ; do mkdir "$i"; touch "$i"/main.py ;done '
alias mkdir='(){if [ $# -gt 1 ] ; then mkdir $@ ; else mkdir $1;cd $1 ;fi}'

# change ls to exa
alias ls='exa'

# go
export GOPATH=$HOME/.ghq
export PATH=$PATH:$HOME/.ghq/bin:$HOME/.local/bin:$HOME/.cabal:/usr/local/bin:$HOME/.cargo/bin

# vim
stty stop undef
stty start undef


# ls
function chpwd() { rename_session && ls }

autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{4}|%F{yellow}+"
zstyle ':vcs_info:git:*' unstagedstr "%F{4}|%F{red}*"
zstyle ':vcs_info:*' formats "%F{4} - [%F{green}%b%c%u%F{4}]"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
# git
function git_information() {
  echo  ${vcs_info_msg_0_}
}

PROMPT='%F{blue}%2~${vcs_info_msg_0_} ${editor_info[keymap]} '
RPROMPT=''

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

  # fbr - checkout git branch (including remote branches)
  fbr() {
    local branches branch
    branches=$(git branch --all | grep -v HEAD) &&
    branch=$(echo "$branches" |
             fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
    git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
    zle reset-prompt
  }
  zle     -N   fbr
  bindkey '^B' fbr

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
      moveto=$(ghq root)/$(ghq list | fzf --height='30%' --layout='reverse')
      if [[ ! -z ${TMUX} ]]
      then
          repo_name=`basename $moveto`
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

  alias stigmata="java -jar ~/stigmata/target/stigmata-5.0-SNAPSHOT.jar"

  function create_session_with_dir() {
      # rename session if in tmux
      moveto=$(pwd)/$(find . -type d | fzf --height='30%' --layout='reverse')
      if [[ ! -z ${TMUX} ]]
      then
          dir_name=`basename $moveto`
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
  zle -N create_session_with_dir
  bindkey '^U' create_session_with_dir

  function remove_session() {
      session_name=$(tmux display-message -p '#S')
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
    dir=$(pwd)
    # remove ghq dir
    if [[ $dir != *".ghq"* ]]; then
      name=$(basename $dir)
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

  function move_cdr() {
      name=$(cdr -l | fzf --height='30%' --layout='reverse')
      if [[ ! -z ${TMUX} ]]
      then
          if [ ! -z ${name} ]
          then
            cdr $(echo $name | awk '{print $1}')
            zle reset-prompt
          else
            zle reset-prompt
          fi
      fi
  }
  zle -N move_cdr
  bindkey '^N' move_cdr

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

# }}}


# =====================git alias============================== {{{
  alias g='git'

  alias ga='git add'
  alias gaa='git add --all'
  alias gapa='git add --patch'
  alias gau='git add --update'
  alias gav='git add --verbose'
  alias gap='git apply'

  alias gb='git branch'
  alias gba='git branch -a'
  alias gbd='git branch -d'
  alias gbda='git branch --no-color --merged | command grep -vE "^(\*|\s*(master|develop|dev)\s*$)" | command xargs -n 1 git branch -d'
  alias gbl='git blame -b -w'
  alias gbnm='git branch --no-merged'
  alias gbr='git branch --remote'
  alias gbs='git bisect'
  alias gbsb='git bisect bad'
  alias gbsg='git bisect good'
  alias gbsr='git bisect reset'
  alias gbss='git bisect start'

  alias gc='git commit -v'
  alias gc!='git commit -v --amend'
  alias gcn!='git commit -v --no-edit --amend'
  alias gca='git commit -v -a'
  alias gca!='git commit -v -a --amend'
  alias gcan!='git commit -v -a --no-edit --amend'
  alias gcans!='git commit -v -a -s --no-edit --amend'
  alias gcam='git commit -a -m'
  alias gcsm='git commit -s -m'
  alias gcb='git checkout -b'
  alias gcf='git config --list'
  alias gcl='git clone --recurse-submodules'
  alias gclean='git clean -fd'
  alias gpristine='git reset --hard && git clean -dfx'
  alias gcm='git checkout master'
  alias gcd='git checkout develop'
  alias gcmsg='git commit -m'
  alias gco='git checkout'
  alias gcount='git shortlog -sn'
  compdef _git gcount
  alias gcp='git cherry-pick'
  alias gcpa='git cherry-pick --abort'
  alias gcpc='git cherry-pick --continue'
  alias gcs='git commit -S'

  alias gd='git diff'
  alias gdca='git diff --cached'
  alias gdcw='git diff --cached --word-diff'
  alias gdct='git describe --tags `git rev-list --tags --max-count=1`'
  alias gds='git diff --staged'
  alias gdt='git diff-tree --no-commit-id --name-only -r'
  alias gdw='git diff --word-diff'

  gdv() { git diff -w "$@" | view - }
  compdef _git gdv=git-diff

  alias gf='git fetch'
  alias gfa='git fetch --all --prune'
  alias gfo='git fetch origin'

  function gfg() { git ls-files | grep $@ }
  compdef _grep gfg

  alias gg='git gui citool'
  alias gga='git gui citool --amend'

  ggf() {
    [[ "$#" != 1 ]] && local b="$(git_current_branch)"
    git push --force origin "${b:=$1}"
  }
  ggfl() {
  [[ "$#" != 1 ]] && local b="$(git_current_branch)"
  git push --force-with-lease origin "${b:=$1}"
  }
  compdef _git ggf=git-checkout

  ggl() {
    if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
      git pull origin "${*}"
    else
      [[ "$#" == 0 ]] && local b="$(git_current_branch)"
      git pull origin "${b:=$1}"
    fi
  }
  compdef _git ggl=git-checkout

  ggp() {
    if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
      git push origin "${*}"
    else
      [[ "$#" == 0 ]] && local b="$(git_current_branch)"
      git push origin "${b:=$1}"
    fi
  }
  compdef _git ggp=git-checkout

  ggpnp() {
    if [[ "$#" == 0 ]]; then
      ggl && ggp
    else
      ggl "${*}" && ggp "${*}"
    fi
  }
  compdef _git ggpnp=git-checkout

  ggu() {
    [[ "$#" != 1 ]] && local b="$(git_current_branch)"
    git pull --rebase origin "${b:=$1}"
  }
  compdef _git ggu=git-checkout

  alias ggpur='ggu'
  compdef _git ggpur=git-checkout

  alias ggpull='git pull origin $(git_current_branch)'
  compdef _git ggpull=git-checkout

  alias ggpush='git push origin $(git_current_branch)'
  compdef _git ggpush=git-checkout

  alias ggsup='git branch --set-upstream-to=origin/$(git_current_branch)'
  alias gpsup='git push --set-upstream origin $(git_current_branch)'

  alias ghh='git help'

  alias gignore='git update-index --assume-unchanged'
  alias gignored='git ls-files -v | grep "^[[:lower:]]"'
  alias git-svn-dcommit-push='git svn dcommit && git push github master:svntrunk'
  compdef _git git-svn-dcommit-push=git

  alias gk='\gitk --all --branches'
  compdef _git gk='gitk'
  alias gke='\gitk --all $(git log -g --pretty=%h)'
  compdef _git gke='gitk'

  alias gl='git pull'
  alias glg='git log --stat'
  alias glgp='git log --stat -p'
  alias glgg='git log --graph'
  alias glgga='git log --graph --decorate --all'
  alias glgm='git log --graph --max-count=10'
  alias glo='git log --oneline --decorate'
  alias glol="git log --graph --pretty='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"
  alias glod="git log --graph --pretty='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'"
  alias glods="git log --graph --pretty='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' --date=short"
  alias glola="git log --graph --pretty='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --all"
  alias glog='git log --oneline --decorate --graph'
  alias gloga='git log --oneline --decorate --graph --all'
  alias glp="_git_log_prettily"
  compdef _git glp=git-log

  alias gm='git merge'
  alias gmom='git merge origin/master'
  alias gmt='git mergetool --no-prompt'
  alias gmtvim='git mergetool --no-prompt --tool=vimdiff'
  alias gmum='git merge upstream/master'
  alias gma='git merge --abort'

  alias gp='git push'
  alias gpd='git push --dry-run'
  alias gpoat='git push origin --all && git push origin --tags'
  compdef _git gpoat=git-push
  alias gpu='git push upstream'
  alias gpv='git push -v'

  alias gr='git remote'
  alias gra='git remote add'
  alias grb='git rebase'
  alias grba='git rebase --abort'
  alias grbc='git rebase --continue'
  alias grbd='git rebase develop'
  alias grbi='git rebase -i'
  alias grbm='git rebase master'
  alias grbs='git rebase --skip'
  alias grh='git reset'
  alias grhh='git reset --hard'
  alias grmv='git remote rename'
  alias grrm='git remote remove'
  alias grset='git remote set-url'
  alias grt='cd $(git rev-parse --show-toplevel || echo ".")'
  alias gru='git reset --'
  alias grup='git remote update'
  alias grv='git remote -v'

  alias gsb='git status -sb'
  alias gsd='git svn dcommit'
  alias gsh='git show'
  alias gsi='git submodule init'
  alias gsps='git show --pretty=short --show-signature'
  alias gsr='git svn rebase'
  alias gss='git status -s'
  alias gst='git status'
  alias gsta='git stash save'
  alias gstaa='git stash apply'
  alias gstc='git stash clear'
  alias gstd='git stash drop'
  alias gstl='git stash list'
  alias gstp='git stash pop'
  alias gsts='git stash show --text'
  alias gsu='git submodule update'

  alias gts='git tag -s'
  alias gtv='git tag | sort -V'

  alias gunignore='git update-index --no-assume-unchanged'
  alias gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'
  alias gup='git pull --rebase'
  alias gupv='git pull --rebase -v'
  alias glum='git pull upstream master'

  alias gwch='git whatchanged -p --abbrev-commit --pretty=medium'
  alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify -m "--wip-- [skip ci]"'

# }}}

# fzf
if [ "$(uname)" = "Linux" ]; then
  source /usr/share/fzf/key-bindings.zsh
  source /usr/share/fzf/completion.zsh

  if [ -n "$DESKTOP_SESSION" ];then
      eval $(gnome-keyring-daemon --start)
      export SSH_AUTH_SOCK
  fi
fi

alias nasm='/usr/local/bin/nasm'

source <(kubectl completion zsh)

# required pup command(https://github.com/ericchiang/pup)
function niconew () {
  rm $HOME/index.html
  echo "<html><header/><body>" > $HOME/index.html
  echo '<meta http-equiv="content-type" charset="utf-8">' >> $HOME/index.html
  for i in `seq 1 10`
  do
    paste -d "\n" <(curl "https://www.nicovideo.jp/newarrival?page=$i" | pup 'a[href]' | grep watch | grep title | sed 's/watch\//https\:\/\/www.nicovideo.jp\/watch\//g') <(curl "https://www.nicovideo.jp/newarrival?page=$i" | pup 'img[src]' | grep smile)  >> $HOME/index.html
  done
  echo "</body></html>" >> $HOME/index.html
  open $HOME/index.html
}

alias pochicomp="java -jar $HOME/pochi/pochi-runner/target/pochi-runner-1.0-SNAPSHOT.jar $HOME/compare.js"

alias bydi="java -jar /Users/mituba/.ghq/src/github.com/tamadalab/bydi/target/bydi-1.0-SNAPSHOT.jar"
export RUST_BACKTRACE=1

alias bydiextract="java -jar /Users/mituba/.ghq/src/github.com/tamadalab/bydi/target/bydi-1.0-SNAPSHOT.jar jp.ac.kyoto_su.ise.tamadalab.bydi.extractor.Main"

alias g++="g++ -std=c++11"

alias coninit='(){curl https://raw.githubusercontent.com/mitubaEX/cpp_template/master/contest_setting.sh | sh -s $1 $2}'
export JAVA_HOME=`/usr/libexec/java_home -v "1.8"`
alias ghci='stack ghci'
alias ghc='stack ghc --'
alias runghc='stack runghc --'

alias nv="nvr --servername $NVIM_LISTEN_ADDRESS"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

printf "\e[4 q"

# ref: https://dev.classmethod.jp/tool/fzf-original-app-for-git-add/
function ggaa() {
    local selected
    selected=$(git status -s | fzf -m --ansi --preview="echo {} | awk '{print \$2}' | xargs git diff --color" | awk '{print $2}')
    if [[ -n "$selected" ]]; then
        selected=$(tr '\n' ' ' <<< "$selected")
        git add $(echo $selected | awk '{sub(/.$/,""); print}')
    fi
}

# Docker completions
if [ -e ~/.zsh/completion ]; then
  fpath=(~/.zsh/completion $fpath)
fi

autoload -Uz compinit && compinit -i

export WINIT_HIDPI_FACTOR="1"

function dexec() {
    local selected
    # selected=$(docker ps --format "table {{.ID}} {{.Names}}" | sed '1d' | fzf --ansi --height='30%' --preview="echo {} | awk '{print \$1}' | xargs docker logs")
    selected=$(docker ps --format "table {{.ID}} {{.Names}}" | sed '1d' | fzf --ansi --height='30%')
    if [[ -n "$selected" ]]; then
      docker exec  -it $(awk '{print $1}' <<< $selected) $@
    fi
}

#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
#
#
# 大文字小文字区別しない
zstyle ':completion:*' matcher-list 'm:{}a-z}={}A-Z}'

# 入力したコマンドがすでにコマンド履歴に含まれる場合、履歴から古いほうのコマンドを削除する
# コマンド履歴とは今まで入力したコマンドの一覧のことで、上下キーでたどれる
setopt hist_ignore_all_dups

# cd した先のディレクトリをディレクトリスタックに追加する
# ディレクトリスタックとは今までに行ったディレクトリの履歴のこと
# `cd -<Tab>` でディレクトリの履歴が表示され、そこに移動できる
setopt auto_pushd

# pushd したとき、ディレクトリがすでにスタックに含まれていればスタックに追加しない
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
# alias nv='nvim'
alias dockerrm='docker rm -f $(docker ps -qa)'
alias dockerrmi='docker rmi -f $(docker images -q)'
alias atmkdir='for i in A B C D ; do mkdir "$i"; touch "$i"/main.py ;done '

# change ls to exa
alias ls='exa'

# go
export GOPATH=$HOME/go:$HOME/.ghq
export PATH=$PATH:$HOME/go/bin:$HOME/.local/bin:$HOME/.cabal:/usr/local/bin

# vim
stty stop undef
stty start undef

# fzf
function fzf-history-selection() {
    BUFFER=`history -n 1 | awk '!a[$0]++' | fzf`
    CURSOR=$#BUFFER
    zle reset-prompt
}

zle -N fzf-history-selection
bindkey '^R' fzf-history-selection

# ls
function chpwd() { rename_session && ls }

# export TERM='screen-256color'

# POWERLEVEL9K_COLOR_SCHEME='dark'

# Advanced `vcs` color customization
# POWERLEVEL9K_VCS_CLEAN_FOREGROUND='white'
# POWERLEVEL9K_VCS_CLEAN_BACKGROUND='070'
# POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='white'
# POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='197'
# POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='white'
# POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='197'
#
# # dir
# POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='white'
# POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='white'
# # POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='039'
# POWERLEVEL9K_DIR_HOME_FOREGROUND='white'
# # POWERLEVEL9K_DIR_HOME_BACKGROUND='039'
#
# # vi
# POWERLEVEL9K_VI_MODE_INSERT_BACKGROUND='white'
# POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND='white'
# POWERLEVEL9K_VI_MODE_INSERT_FOREGROUND='241'
# POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND='039'
#
# # icon
# POWERLEVEL9K_OS_ICON_BACKGROUND="white"
# POWERLEVEL9K_OS_ICON_FOREGROUND="blue"
#
# # newline
# POWERLEVEL9K_PROMPT_ON_NEWLINE=true
#
# # time
# POWERLEVEL9K_TIME_FORMAT="%D{%H:%M:%S | %y/%m/%d}"
#
# POWERLEVEL9K_TIME_FORMAT="%D{%H:%M:%S}"
# POWERLEVEL9K_TIME_BACKGROUND="249"
#
# # context
# POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND="039"
# POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND="white"
# POWERLEVEL9K_HOST_REMOTE_BACKGROUND="197"
# POWERLEVEL9K_HOST_REMOTE_FOREGROUND="white"
#
# # user
# POWERLEVEL9K_USER_DEFAULT_BACKGROUND="white"
# POWERLEVEL9K_USER_DEFAULT_FOREGROUND="black"
# POWERLEVEL9K_USER_ROOT_BACKGROUND="white"
# POWERLEVEL9K_USER_ROOT_FOREGROUND="red"
#
# # battery
# POWERLEVEL9K_BATTERY_CHARGED_BACKGROUND="white"
# POWERLEVEL9K_BATTERY_CHARGING_BACKGROUND="white"
# POWERLEVEL9K_BATTERY_LOW_BACKGROUND="white"
#
# # status
# POWERLEVEL9K_STATUS_OK_BACKGROUND="white"
#
# # writable
# POWERLEVEL9K_DIR_WRITABLE_BACKGROUND="white"
# POWERLEVEL9K_DIR_WRITABLE_FOREGROUND="black"

# POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
#
# POWERLEVEL9K_SHORTEN_DELIMITER=..
# POWERLEVEL9K_VI_INSERT_MODE_STRING="😍"
# POWERLEVEL9K_VI_COMMAND_MODE_STRING="😐"
#
# # multiline
# POWERLEVEL9K_PROMPT_ON_NEWLINE=true
# POWERLEVEL9K_RPROMPT_ON_NEWLINE=false
# POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{014}╭%F{cyan}"
# POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{014}\u2570%F{cyan}\uF460%F{073}\uF460%F{109}\uF460%f "
#
# # command_execution_time
# POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='white'
# POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='blue'
# POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0
#
# POWERLEVEL9K_RAM_BACKGROUND='white'
# POWERLEVEL9K_IP_BACKGROUND='white'
#
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

# POWERLEVEL9K_CUSTOM_GIT_INFO="git_information"
# POWERLEVEL9K_CUSTOM_GIT_INFO_BACKGROUND="black"
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=( vi_mode custom_git_info ssh dir )
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=( dir_writable command_execution_time )

# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=( status dir_writable command_execution_time ip time )
#
#
PROMPT='${SSH_TTY:+"%F{9}%n%f%F{7}@%f%F{3}%m%f "}%F{4}${_prompt_sorin_pwd}%(!. %B%F{1}#%f%b.)$(git_information)${editor_info[keymap]} '
RPROMPT=''

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
  ID="`echo $ID | fzf | cut -d: -f1`"
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
    moveto=$(ghq root)/$(ghq list | fzf)
    if [[ ! -z ${TMUX} ]]
    then
        repo_name=`basename $moveto`
        if [ $repo_name != `basename $(ghq root)` ]
        then
          tmux new-session -d -c $moveto -s $repo_name  2> /dev/null
          tmux switch-client -t $repo_name 2> /dev/null
        fi
    fi
}

zle -N create_session_with_ghq
bindkey '^G' create_session_with_ghq

# function delete_repository_with_ghq() {
#   repo=$(ghq root)/$(ghq list | fzf)
#   if [ `basename $repo` != `basename $(ghq root)` ]
#   then
#     rm -rf $repo
#   fi
# }
# zle -N delete_repository_with_ghq
# bindkey '^X' delete_repository_with_ghq

alias stigmata="java -jar ~/stigmata/target/stigmata-5.0-SNAPSHOT.jar"

function create_session_with_dir() {
    # rename session if in tmux
    moveto=$(pwd)/$(find . -type d | fzf)
    if [[ ! -z ${TMUX} ]]
    then
        dir_name=`basename $moveto`
        if [ $dir_name != `basename $(pwd)` ]
        then
          tmux new-session -d -c $moveto -s $dir_name  2> /dev/null
          tmux switch-client -t $dir_name 2> /dev/null
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
        fi
    fi
}
zle -N remove_session
bindkey '^X' remove_session

alias ghci='stack ghci'
alias ghc='stack ghc --'
alias runghc='stack runghc --'

alias nv="nvr --servername $NVIM_LISTEN_ADDRESS"

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

# function move_cdr() {
#     name=$(cdr -l | fzf)
#     if [[ ! -z ${TMUX} ]]
#     then
#         if [ ! -z ${name} ]
#         then
#           cdr $(echo $name | awk '{print $1}')
#         fi
#     fi
# }
# zle -N move_cdr
# bindkey '^N' move_cdr

# ref: https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/git/git.plugin.zsh
# Aliases
# (sorted alphabetically)
#

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -l -g ""'


# =====================git alias==============================

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

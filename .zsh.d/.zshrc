# zshの起動時のprofile表示用の設定
# zprofの呼び出しをファイルの下に置くと
# profileをゲットできる
# zmodload zsh/zprof
# if (which zprof > /dev/null 2>&1) ;then
#   zprof
# fi

. $ZDOTDIR/utils/alias.zsh
. $ZDOTDIR/utils/env-tools.zsh
. $ZDOTDIR/utils/fzf-config.zsh
. $ZDOTDIR/utils/fzf-functions.zsh
. $ZDOTDIR/utils/git-alias.zsh
# . $ZDOTDIR/utils/zplugins.zsh

# no check uppper case and lower case
zstyle ':completion:*' matcher-list 'm:{}a-z}={}A-Z}'

# 履歴ファイルの保存先
export HISTFILE=${HOME}/.zsh_history

# メモリに保存される履歴の件数
export HISTSIZE=1000

# 履歴ファイルに保存される履歴の件数
export SAVEHIST=100000

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
bindkey -v '^F'   forward-char
bindkey -v '^B'   backward-char
bindkey -v '^K'   up-line-or-history
bindkey -v '^J'   down-line-or-history
bindkey -v '^P'   up-line-or-history
bindkey -v '^N'   down-line-or-history

# lang
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# go
export GOPATH=$HOME/.ghq
export PATH=$PATH:$HOME/.ghq/bin:$HOME/.local/bin:$HOME/.rbenv/bin:$HOME/.cabal:/usr/local/bin:$HOME/.cargo/bin

# vim
stty stop undef
stty start undef

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH:$HOME/node_modules/.bin"

# 全体で共有したい情報はこれを使う
# source $HOME/.env

# Docker completions
if [ -e ~/.zsh/completion ]; then
  fpath=(~/.zsh/completion $fpath)
fi

printf "\e[4 q"

# ls
function chpwd() { rename_session && ls }

# anyenv initを起動時にやりたくなかったので、
# 一旦この対応、goなども追加する場合はregex conditionを
# どこかに変数または関数化したら良さそう
function preexec() {
  if [[ $1 =~ 'bundle|rails|rspec|yarn|npm' ]]
  then
    eval "$(anyenv init - --no-rehash)"
  fi
}

function gcopr() {
  git fetch upstream pull/$1/head:$1
  git checkout $1
}

function gplpr() {
  git pull upstream pull/$(git branch | grep \* | cut -d ' ' -f2)/head
}

if [ -f './crefre.sh' ]; then
  source ./crefre.sh
fi

POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true

export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

# create_vim_plugin
function create_vim_plugin() {
  git clone https://github.com/mitubaEX/create_vim_plugin.git
  rm create_vim_plugin/.git
  mv create_vim_plugin/* . && mv create_vim_plugin/.* .
  rm create_vim_plugin

  find . -name "*sampleapp*" -type f | while read filename
  do
    dirname=$(dirname $filename)
    extension="${filename##*.}"

    # rename include file string
    sed -i '' "s/sampleapp/$1/g" $filename

    # rename file name
    mv $filename "$dirname/$1.$extension"
  done
}

# source deno_completions
if [[ -f $HOME/.config/deno_completions.zsh ]];then
  source $HOME/.config/deno_completions.zsh
fi

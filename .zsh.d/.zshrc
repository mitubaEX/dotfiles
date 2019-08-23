. $ZDOTDIR/utils/alias.zsh
. $ZDOTDIR/utils/env-tools.zsh
. $ZDOTDIR/utils/fzf-config.zsh
. $ZDOTDIR/utils/fzf-functions.zsh
. $ZDOTDIR/utils/git-alias.zsh
. $ZDOTDIR/utils/zplugins.zsh

# no check uppper case and lower case
zstyle ':completion:*' matcher-list 'm:{}a-z}={}A-Z}'

# 履歴ファイルの保存先
export HISTFILE=${HOME}/.zsh_history

# メモリに保存される履歴の件数
export HISTSIZE=1000

# 履歴ファイルに保存される履歴の件数
export SAVEHIST=100000

export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

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

# lang
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# go
export GOPATH=$HOME/.ghq
export PATH=$PATH:$HOME/.ghq/bin:$HOME/.local/bin:$HOME/.rbenv/bin:$HOME/.cabal:/usr/local/bin:$HOME/.cargo/bin

# vim
stty stop undef
stty start undef

export NRFSDK12_ROOT=$HOME/Downloads/nRF5_SDK_12.3.0_d7731ad/nRF5_SDK_12.3.0_d7731ad

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH:$HOME/node_modules/.bin"
source $HOME/.env

export NRFSDK15_ROOT=$HOME/nRF5_SDK_15.0.0_a53641a

# alacritty
export WINIT_HIDPI_FACTOR="1"

# Docker completions
if [ -e ~/.zsh/completion ]; then
  fpath=(~/.zsh/completion $fpath)
fi

printf "\e[4 q"

# ls
function chpwd() { rename_session && ls }

# PROMPT='%F{blue}%2~${vcs_info_msg_0_} ${editor_info[keymap]} '
# RPROMPT=''

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

function gcopr() {
  git fetch upstream pull/$1/head:$1
  git checkout $1
}

function gplpr() {
  git pull upstream pull/$(git branch | grep \* | cut -d ' ' -f2)/head
}

# check performance
# if (which zprof > /dev/null) ;then
#   zprof | less
# fi


## repo path
export CTAX_PATH=~/freee-ctax
export ALPHA_PATH=~/.ghq/src/github.com/mitubaEX/CFO-Alpha
export MYNUMBER_PATH=~/.ghq/src/github.com/C-FO/freee-mynumber
export PAYROLL_PATH=~/.ghq/src/github.com/C-FO/freee-payroll

function inifre() {
  xpanes -e -x "cd $CTAX_PATH && INTEGRATE_C_TAX_FORM_TOOL=1 LOGIN_EMAIL=test+a@c-fo.com RAILS_RELATIVE_URL_ROOT=/ctax bundle exec rails s -b 0.0.0.0 -p 3200" "cd $CTAX_PATH && RAILS_RELATIVE_URL_ROOT=/ctax yarn run serve"

  xpanes -e -x "cd $ALPHA_PATH && docker-compose up -d && bundle exec rails s -b 0.0.0.0" "cd $ALPHA_PATH && npm run watch"

  xpanes -e -x "cd $MYNUMBER_PATH && make rails-server"
}

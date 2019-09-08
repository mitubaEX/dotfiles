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
source $HOME/.env

# Docker completions
if [ -e ~/.zsh/completion ]; then
  fpath=(~/.zsh/completion $fpath)
fi

printf "\e[4 q"

# ls
function chpwd() { rename_session && ls }

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
export TAX_OPERATION_PATH=~/.ghq/src/github.com/mitubaEX/freee-tax-operation

function inifre() {
 xpanes -e -x "cd $ALPHA_PATH && docker-compose up -d && bundle exec rails s -b 0.0.0.0" "cd $ALPHA_PATH && npm run watch"

 xpanes -e -x "cd $CTAX_PATH && direnv reload && INTEGRATE_C_TAX_FORM_TOOL=1 LOGIN_EMAIL=test+a@c-fo.com RAILS_RELATIVE_URL_ROOT=/ctax bundle exec rails s -b 0.0.0.0 -p 3200" "cd $CTAX_PATH && RAILS_RELATIVE_URL_ROOT=/ctax yarn run serve"

  xpanes -e -x "cd $MYNUMBER_PATH && make rails-server"

  xpanes -e -x "cd $PAYROLL_PATH && ./bin/rails s -p 3001" "cd $PAYROLL_PATH && yarn watch"

  xpanes -e -x "cd $TAX_OPERATION_PATH && ./bin/rails s -p 3005" "cd $TAX_OPERATION_PATH && bin/webpack-dev-server"
}

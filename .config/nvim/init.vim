autocmd BufWritePre * :%s/\s\+$//ge
filetype indent plugin on

language en_US.UTF-8

au VimLeave * set guicursor=a:hor100

let g:NERDTreeWinSize=30
let g:NERDTreeQuitOnOpen=1

" neosnippet
let g:neosnippet#enable_completed_snippet = 1

let g:node_host_prog = '$HOME/node_modules/.bin/neovim-node-host'

" source each config
source $HOME/.config/nvim/config/dein_script.vimrc
source $HOME/.config/nvim/config/set.vimrc
source $HOME/.config/nvim/config/keybinds.vimrc
source $HOME/.config/nvim/config/lsp.vimrc
source $HOME/.config/nvim/config/fzf_functions.vimrc
source $HOME/.config/nvim/config/coc.vimrc
source $HOME/.config/nvim/config/util_script.vimrc
hi! Normal ctermbg=NONE guibg=NONE

if has("autocmd")
  augroup templates
    autocmd BufNewFile *.cc 0r ~/.config/nvim/template/main.cc

    autocmd BufNewFile *_spec.rb 0r ~/.config/nvim/template/template_spec.rb
  augroup END
endif

" indentLine
let g:indentLine_faster = 1
autocmd VimEnter,Colorscheme * :IndentLinesToggle

" dein install
if dein#check_install()
  call dein#install()
endif

" command window
" 行数を非表示
autocmd CmdwinEnter [:\/\?=] setlocal nonumber
" signcolumn を非表示
autocmd CmdwinEnter [:\/\?=] setlocal signcolumn=no
autocmd CmdwinEnter : g/^qa\?!\?$/d
autocmd CmdwinEnter : g/^wq\?a\?!\?$/d

" easy motion color
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade  Comment

hi link EasyMotionTarget2First MatchParen
hi link EasyMotionTarget2Second MatchParen

let test#strategy = "neovim"

hi FloatermNF guibg=black
hi FloatermBorderNF guibg=black guifg=white
let g:floaterm_position = 'center'
let g:floaterm_width = 0.9
let g:floaterm_height = 0.8

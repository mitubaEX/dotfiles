autocmd BufWritePre * :%s/\s\+$//ge
filetype indent plugin on

language en_US.UTF-8

au VimLeave * set guicursor=a:hor100

let g:NERDTreeWinSize=30
let g:NERDTreeQuitOnOpen=1

" neosnippet
let g:neosnippet#enable_completed_snippet = 1

let g:vim_markdown_folding_disabled = 1

" rainbow_parentheses.vim {{{
let g:rbpt_colorpairs = [
	    \ ['brown',       'RoyalBlue3'],
	    \ ['Darkblue',    'SeaGreen3'],
	    \ ['darkgray',    'DarkOrchid3'],
	    \ ['darkgreen',   'firebrick3'],
	    \ ['darkcyan',    'RoyalBlue3'],
	    \ ['darkred',     'SeaGreen3'],
	    \ ['darkmagenta', 'DarkOrchid3'],
	    \ ['brown',       'firebrick3'],
	    \ ['gray',        'RoyalBlue3'],
	    \ ['darkmagenta', 'DarkOrchid3'],
	    \ ['Darkblue',    'firebrick3'],
	    \ ['darkgreen',   'RoyalBlue3'],
	    \ ['darkcyan',    'SeaGreen3'],
	    \ ['darkred',     'DarkOrchid3'],
	    \ ['red',         'firebrick3'],
	    \ ]

let g:rbpt_max = 15
let g:rbpt_loadcmd_toggle = 0

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
" }}}
let g:latex_latexmk_options = '-pdf'

let g:node_host_prog = '$HOME/node_modules/.bin/neovim-node-host'

" source each config
source $HOME/.config/nvim/config/dein_script.vimrc
source $HOME/.config/nvim/config/set.vimrc
source $HOME/.config/nvim/config/keybinds.vimrc
source $HOME/.config/nvim/config/lsp.vimrc
source $HOME/.config/nvim/config/fzf_functions.vimrc
hi! Normal ctermbg=NONE guibg=NONE

if has("autocmd")
  augroup templates
    autocmd BufNewFile *.cc 0r ~/.config/nvim/template/main.cc
  augroup END
endif

" indentLine
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
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

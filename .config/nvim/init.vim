source $HOME/.config/nvim/config/dein_script.vimrc
source $HOME/.config/nvim/config/set.vimrc
source $HOME/.config/nvim/config/keybinds.vimrc
source $HOME/.config/nvim/config/lsp.vimrc

autocmd BufWritePre * :%s/\s\+$//ge
filetype indent plugin on

language en_US.UTF-8
" vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size=1

au VimLeave * set guicursor=a:hor100

let g:NERDTreeWinSize=30
let g:NERDTreeQuitOnOpen=1

" neosnippet
let g:neosnippet#enable_completed_snippet = 1

let g:vim_markdown_folding_disabled = 1


" easymotion {{{
let mapleader = "\<Space>"
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Move to word
map  <Leader>l <Plug>(easymotion-bd-w)
nmap <Leader>l <Plug>(easymotion-overwin-w)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
" }}}

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

hi! Visual ctermbg=236 guibg=#363d5b
hi! Normal ctermbg=NONE guibg=NONE

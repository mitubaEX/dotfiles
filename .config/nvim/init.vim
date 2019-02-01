" dein Scripts----------------------------- {{{
if &compatible
    set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.cache/dein')
    call dein#begin('~/.cache/dein')

    " Let dein manage dein
    " Required:
    call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

    " Add or remove your plugins here:
    call dein#add('Shougo/neosnippet.vim')
    call dein#add('Shougo/neosnippet-snippets')
    call dein#load_toml('~/dein.toml')
    if !has('nvim')
	call dein#add('roxma/nvim-yarp')
	call dein#add('roxma/vim-hug-neovim-rpc')
    endif

    " You can specify revision/branch/tag.
    " call dein#add('Shougo/deol.nvim')

    " Required:
    call dein#end()
    call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

"End dein Scripts------------------------- }}}
autocmd BufWritePre * :%s/\s\+$//ge
filetype indent plugin on

" set {{{
set hidden
set wildmenu
set showcmd
set wildmode=list,full
set wildignorecase
set shell=$SHELL
set title " set terminal title
set showmatch " show matching braces

" search
set hlsearch
set ignorecase
set smartcase
set smartindent
set incsearch
set inccommand=split
set nolazyredraw

set magic

set backspace=indent,eol,start
set nostartofline
set ruler
set laststatus=2
set confirm
set visualbell
set t_vb=
set cmdheight=1
set whichwrap=b,s,<,>,[,],h,l

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,cp932
set fenc=utf-8
scriptencoding utf-8
set wrap
set autoindent
set ttyfast
set number
set sm
set ai
set noswapfile
set cursorline
set cursorcolumn

set linebreak
set showbreak=…
set so=7

" color
colorscheme gruvbox
set background=dark
highlight Normal ctermbg=None
set t_Co=256
let g:gruvbox_contrast_dark="hard"


" clipboard combination
set clipboard+=unnamedplus
set tabstop=2
set shiftwidth=2
set expandtab

" If installed using Homebrew
set rtp+=/usr/local/opt/fzf

set wrapscan

se ff=unix

set ttimeout
set ttimeoutlen=50

set virtualedit=block

set foldmethod=marker
set foldlevel=2
set foldcolumn=1
" }}}
"
" keybind {{{
nmap <Leader>c <Plug>(caw:hatpos:toggle)
vmap <Leader>c <Plug>(caw:hatpos:toggle)

" reader ref:https://postd.cc/how-to-boost-your-vim-productivity/
let mapleader = "\<Space>"
nnoremap <Leader>w <Esc>:w<CR>
nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>s :source .config/nvim/init.vim<CR>

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
inoremap <C-s> <Nop>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-e> :terminal<Enter>

" move method of cursor in insert mode
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

nnoremap <tab> gt
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-q> <Esc>:BufferClose<Enter>

" bd or q command
function! s:bufferClose() abort
    if len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
	execute "q"
    else
	execute "bd"
    endif
endfunction
command! -nargs=* BufferClose call s:bufferClose()

" vertical split
nnoremap <C-s> :split<Enter>
" horizontal split
nnoremap <C-y> :vsplit<Enter>

" escape
inoremap <silent> jj <ESC>

" move previous buffer
nnoremap <C-n> :b #<Enter>

tnoremap <silent> <ESC> <C-\><C-n>

" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"


" >>>>>>>>>>>>>>>>git>>>>>>>>>>>>>>>>>>>>
nnoremap [vim-fugitive] <Nop>
nmap <C-g> [vim-fugitive]

" status
nnoremap <silent> [vim-fugitive]s  :<C-u>Gstatus<CR>

" diff
nnoremap <silent> [vim-fugitive]d  :<C-u>Gdiff<CR>

" add
nnoremap <silent> [vim-fugitive]a  :<C-u>Gwrite<CR>

" commit
nnoremap <silent> [vim-fugitive]c  :<C-u>Gcommit<CR>
" >>>>>>>>>>>>>>>>git>>>>>>>>>>>>>>>>>>>>

noremap <Leader>p "0p
noremap <Leader>P "0P
vnoremap <Leader>p "0p
nmap <leader>s <Plug>yankstack_substitute_older_paste
nmap <leader>S <Plug>yankstack_substitute_newer_paste

" fzf
nmap <Leader>t :Files<CR>
nmap <Leader>a :Rg<CR>
nmap <Leader>c :Tags<CR>

" Codic
nmap <Leader>C :Codic<Space>

nnoremap <Leader>h za

nnoremap <Esc><Esc> :noh<CR>

" Tagbar
nmap <C-p> :TagbarToggle<CR>

" insert new line without entering insert mode
nnoremap <Leader>o o<Esc>

" }}}

language en_US.UTF-8
" vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size=1

au VimLeave * set guicursor=a:hor100

let g:NERDTreeWinSize=30
let g:NERDTreeQuitOnOpen=1
" Use deoplete.
let g:deoplete#enable_at_startup = 1

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
	    \ ['black',       'SeaGreen3'],
	    \ ['darkmagenta', 'DarkOrchid3'],
	    \ ['Darkblue',    'firebrick3'],
	    \ ['darkgreen',   'RoyalBlue3'],
	    \ ['darkcyan',    'SeaGreen3'],
	    \ ['darkred',     'DarkOrchid3'],
	    \ ['red',         'firebrick3'],
	    \ ]

let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
" }}}
let g:latex_latexmk_options = '-pdf'

"dein Scripts-----------------------------
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
  call dein#add('Shougo/deol.nvim', { 'rev': 'a1b5108fd' })

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

"End dein Scripts-------------------------
autocmd BufWritePre * :%s/\s\+$//ge
filetype indent plugin on
set hidden
set wildmenu
set showcmd
set hlsearch
set ignorecase
set smartcase
set backspace=indent,eol,start
set nostartofline
set ruler
set laststatus=2
set confirm
set visualbell
set t_vb=
set cmdheight=1
set whichwrap=b,s,<,>,[,],h,l
nmap <Leader>c <Plug>(caw:hatpos:toggle)
vmap <Leader>c <Plug>(caw:hatpos:toggle)

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,cp932
set wrap
set autoindent
set number
set sm
set ai
set noswapfile
set cursorline
set cursorcolumn

" color
" let g:rehash256 = 1
" colorscheme molokai
" let g:solarized_termtrans = 1
" set background=light
" colorscheme solarized
colorscheme gruvbox
set background=dark
highlight Normal ctermbg=None
set t_Co=256
let g:gruvbox_contrast_dark="hard"

" クリップボード連携
set clipboard+=unnamedplus
set tabstop=2
set shiftwidth=2
set expandtab

" reader ref:https://postd.cc/how-to-boost-your-vim-productivity/
let mapleader = "\<Space>"
nnoremap <Leader>w <Esc>:w<CR>
" inoremap <Leader>w <Esc>:w<CR>
nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>s :source .config/nvim/init.vim<CR>

"<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<独自キーバインド<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
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

let g:NERDTreeWinSize=30
let g:NERDTreeQuitOnOpen=1


" inoremap <C-[> <Nop>
" imap <C-[> <Esc>:w<CR>
" nmap <C-[> <Esc>:w<CR>
" inoremap <Esc> <Esc>:w<CR>
" 挿入モードでのカーソル移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
" inoremap <Esc> <Esc>:<C-u>w<CR>
" inoremap <Esc> <Esc>:<C-u>w<CR>
"
" nnoremap <C-s> :set spell<Enter>
nnoremap <tab> gt
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-q> <Esc>:q<Enter>
" 縦にsplitする
nnoremap <C-s> :split<Enter>
" 横にsplitする
nnoremap <C-y> :vsplit<Enter>

inoremap <silent> jj <ESC>

" move previous buffer
nnoremap <C-n> :b #<Enter>
">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>独自キーバインド>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

tnoremap <silent> <ESC> <C-\><C-n>

" Use deoplete.
let g:deoplete#enable_at_startup = 1
" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" neosnippet
let g:neosnippet#enable_completed_snippet = 1

" If installed using Homebrew
set rtp+=/usr/local/opt/fzf

let g:vim_markdown_folding_disabled = 1

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

set ignorecase
set smartcase
set wrapscan
set incsearch
set inccommand=split

se ff=unix

set ttimeout
set ttimeoutlen=50

noremap <Leader>p "0p
noremap <Leader>P "0P
vnoremap <Leader>p "0p

" fzf
nmap <Leader>t :Files<CR>
nmap <Leader>a :Ag<Space>

" Codic
nmap <Leader>c :Codic<Space>

au VimLeave * set guicursor=a:hor100

set virtualedit=block

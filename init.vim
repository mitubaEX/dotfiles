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

" color
" let g:rehash256 = 1
" colorscheme molokai
set background=dark
colorscheme solarized
set t_Co=256

" クリップボード連携
set clipboard+=unnamed
set tabstop=2
set shiftwidth=2
set expandtab

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
inoremap <C-[> <Esc>:w<Enter>
" 挿入モードでのカーソル移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
nnoremap <C-[> :w<Enter>
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
">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>独自キーバインド>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

tnoremap <silent> <ESC> <C-\><C-n>

" Use deoplete.
let g:deoplete#enable_at_startup = 1
" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" neosnippet
let g:neosnippet#enable_completed_snippet = 1


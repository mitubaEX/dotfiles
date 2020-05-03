set hidden
set wildmenu
set showcmd
set wildmode=list:longest,full
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

set linebreak
set showbreak=…
set so=7

set termguicolors
syntax enable

" color
" let g:seoul256_background = 234
colorscheme hybrid

" silent! colorscheme onehalfdark
"
" if exists('+termguicolors')
"   let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"   let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
"   set termguicolors
" endif

set background=dark

" highlight Comment cterm=italic
" highlight Normal guibg=NONE ctermbg=NONE
" highlight NormalFloat guibg=NONE ctermbg=NONE

" set t_Co=256
" let g:seoul256_srgb = 1

" set termguicolors     " enable true colors support
" let ayucolor="light"  " for light version of theme
" let ayucolor="mirage" " for mirage version of theme
" let ayucolor="dark"   " for dark version of theme
" colorscheme ayu

" clipboard combination
set clipboard+=unnamedplus
set tabstop=2
set shiftwidth=2
set expandtab

" fzf condition
if has("mac")
    set rtp+=/usr/local/opt/fzf
elseif has("unix")
    set rtp+=~/.fzf
endif

set wrapscan

se ff=unix

set ttimeout
set ttimeoutlen=50

set virtualedit=block

set foldmethod=marker
set foldlevel=2
set foldcolumn=1

" inifinite undo
set undofile
if !isdirectory(expand("$HOME/.vim/undodir"))
  call mkdir(expand("$HOME/.vim/undodir", "p"))
endif
set undodir=$HOME/.vim/undodir

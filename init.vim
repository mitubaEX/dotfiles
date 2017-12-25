"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/Users/mituba/.cache/dein/repos/github.com/Shougo/dein.vim

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

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

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
nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,cp932
set wrap
set autoindent
set number
set sm
set ai
set noswapfile



syntax on0autocmd ColorScheme * highlight Visual ctermbg=75
autocmd ColorScheme * highlight Visual ctermbg=75
autocmd ColorScheme * highlight Comment ctermfg=390
colorscheme molokai
set t_Co=256
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   ctermbg=247
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=246
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
			\ 'default' : ''
      \ }

" クリップボード連携
set clipboard+=unnamed
set tabstop=2
set shiftwidth=2
set expandtab

set statusline=%F%m%r%h%w%=\ %{fugitive#statusline()}\ [%{&ff}:%{&fileencoding}]\ [%Y]\ [%04l,%04v]\ [%l/%L]\ %{strftime(\"%Y/%m/%d\ %H:%M:%S\")}



""""""""""""""""""""""""""""""""""""""""独自キーバインド"""""""""""""""""""""""
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
inoremap <C-w> <Esc>:w<Enter>
" 挿入モードでのカーソル移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
nnoremap <C-w> :w<Enter>
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
imap { {}<C-h>
imap [ []<C-h>
imap ( ()<C-h>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

au BufRead,BufNewFile *.jsx set filetype=javascript.jsx
let g:jsx_ext_required = 0 " Allow JSX in normal JS files
tnoremap <silent> <ESC> <C-\><C-n>

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

" クリップボード連携
set clipboard+=unnamed
set tabstop=2
set shiftwidth=2
set expandtab

set statusline=%F%m%r%h%w%=\ %{fugitive#statusline()}\ [%l/%L]\

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
" imap < <><C-h>
imap ( ()<C-h>
">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>独自キーバインド>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

tnoremap <silent> <ESC> <C-\><C-n>


"<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<denite<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
" 参考:http://replicity.hateblo.jp/entry/2017/06/03/140731
"
"C-j,C-kで上下移動
call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')
"ESCキーでdeniteを終了
call denite#custom#map('insert', '<esc>', '<denite:enter_mode:normal>', 'noremap')
call denite#custom#map('normal', '<esc>', '<denite:quit>', 'noremap')

" C-sでsplit表示
call denite#custom#map('insert', '<C-s>', '<denite:do_action:vsplit>', 'noremap')

" tabopen
call denite#custom#map('insert', "<C-t>", '<denite:do_action:tabopen>', 'noremap')

" プロンプトの左端に表示される文字を指定
call denite#custom#option('default', 'prompt', '>')

" Deniteの設定
nnoremap [denite] <Nop>
nmap <C-f> [denite]

" -buffer-name=
nnoremap <silent> [denite]g  :<C-u>Denite grep -buffer-name=search-buffer-denite<CR>

" Denite grep検索結果を再表示する
nnoremap <silent> [denite]r :<C-u>Denite -resume -buffer-name=search-buffer-denite<CR>
" resumeした検索結果の次の行の結果へ飛ぶ
nnoremap <silent> [denite]n :<C-u>Denite -resume -buffer-name=search-buffer-denite -select=+1 -immediately<CR>
" resumeした検索結果の前の行の結果へ飛ぶ
nnoremap <silent> [denite]p :<C-u>Denite -resume -buffer-name=search-buffer-denite -select=-1 -immediately<CR>
">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>denite>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

" Use deoplete.
let g:deoplete#enable_at_startup = 1
" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" neosnippet
let g:neosnippet#enable_completed_snippet = 1

"""ale""""""""""
let g:ale_fixers = {'python': ['autopep8', 'isort'],}
let g:ale_fix_on_save = 1
"""ale""""""""""


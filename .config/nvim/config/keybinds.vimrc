" reader ref:https://postd.cc/how-to-boost-your-vim-productivity/
let maplocalleader = "\\"
let mapleader = "\<Space>"
nmap <LocalLeader>c <Plug>(caw:hatpos:toggle)
vmap <LocalLeader>c <Plug>(caw:hatpos:toggle)

nnoremap <Leader>w <Esc>:w<CR>
nnoremap <Leader>o :CtrlP<CR>

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
inoremap <C-s> <Nop>
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
" nnoremap <C-y> :vsplit<Enter>

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

" blame
nnoremap <silent> [vim-fugitive]b  :<C-u>Gblame<CR>

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

" Codic
nmap <Leader>C :Codic<Space>

nnoremap <Leader>h za

nnoremap <Esc><Esc> :noh<CR>

" Tagbar
nmap <C-p> :TagbarToggle<CR>

" insert new line without entering insert mode
nnoremap <Leader>o o<Esc>

" indent all lines
map <Leader>= gg=G<C-o><C-o>

" defx
nnoremap <Leader>n :<C-u>Defx `expand('%:p:h')` -columns=icons:filename:type -search=`expand('%:p')`<CR>

nmap <Leader>c :!echo "%:t" \| pbcopy<CR>

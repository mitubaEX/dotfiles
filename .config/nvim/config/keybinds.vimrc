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

" move method of cursor in insert mode
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

nnoremap <tab> gt
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

" escape
inoremap <silent> jj <ESC>

" move previous buffer
nnoremap <Leader>n :b #<Enter>
tnoremap <silent> <ESC> <C-\><C-n>

" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"


" >>>>>>>>>>>>>>>>git>>>>>>>>>>>>>>>>>>>>
nnoremap [vim-fugitive] <Nop>
nmap <C-g> [vim-fugitive]

" status
" nnoremap <silent> [vim-fugitive]s  :<C-u>Gstatus<CR>

" diff
nnoremap <silent> [vim-fugitive]d  :<C-u>Gdiff<CR>

" blame
nnoremap <silent> [vim-fugitive]b  :<C-u>Gblame<CR>

" add
nnoremap <silent> [vim-fugitive]a  :<C-u>Gwrite<CR>

" commit
" nnoremap <silent> [vim-fugitive]c  :<C-u>Gcommit<CR>

" browse
nnoremap <silent> [vim-fugitive]w  :<C-u>Gbrowse<CR>

""" Gina
" grep
nnoremap <C-g>g  :<C-u>Gina grep<CR>

" diff
" nnoremap <C-g>d  :<C-u>Gina diff<CR>

" commit
nnoremap <C-g>c  :<C-u>Gina commit -v<CR>

" status
nnoremap <C-g>s  :<C-u>Gina status<CR>


" log
function! s:gLogCurrentFile() abort
	let cfile = expand('%')
	execute "Gina log " . cfile
endfunction
command! -nargs=* GLogCurrentFile call s:gLogCurrentFile()
nnoremap <C-g>l  :<C-u>GLogCurrentFile<CR>
" >>>>>>>>>>>>>>>>git>>>>>>>>>>>>>>>>>>>>

noremap <Leader>p "0p
noremap <Leader>P "0P
vnoremap <Leader>p "0p

nnoremap <Esc><Esc> :noh<CR>

" insert new line without entering insert mode
nnoremap <Leader>o o<Esc>

" indent all lines
map <Leader>= gg=G<C-o><C-o>

" defx
nnoremap <Leader>d :<C-u>Defx `expand('%:p:h')` -columns=git:icons:filename:type -search=`expand('%:p')`<CR>

" pbcopy filename
"" only filename
nmap <Leader>c :!echo "%:t" \| pbcopy<CR>
"" relative path
nmap <Leader>C :!echo "%" \| pbcopy<CR>

nnoremap <Leader>- :CleverSplit<CR>

" easymotion {{{
" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_mapping = 0 " Disable default mappings

map  <Leader><Leader> <Plug>(easymotion-bd-w)
nmap <Leader><Leader> <Plug>(easymotion-overwin-w)
" }}}

" vim-test
nmap <Leader>q :TestFile<CR>
nmap <Leader>Q :TestNearest<CR>

""" Example configuration
let g:floaterm_keymap_new    = '<Leader>f'
let g:floaterm_keymap_toggle = '<Leader>f'

" float_timer
" nnoremap <Leader>f :FloatTimer 25<CR>

" reload config file
nnoremap <Leader>R :so ~/.config/nvim/init.vim<CR>

" columnskip
nmap <Leader>j <Plug>(columnskip:nonblank:next)
omap <Leader>j <Plug>(columnskip:nonblank:next)
xmap <Leader>j <Plug>(columnskip:nonblank:next)
nmap <Leader>k <Plug>(columnskip:nonblank:prev)
omap <Leader>k <Plug>(columnskip:nonblank:prev)
xmap <Leader>k <Plug>(columnskip:nonblank:prev)

" previous jump
nnoremap <C-p> <C-i>

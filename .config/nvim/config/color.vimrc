set termguicolors
syntax enable

" color
" let g:seoul256_background = 234
set background=dark

" gruvbox-material {{{
" let g:gruvbox_material_background = 'hard'
" colorscheme gruvbox-material
" }}}
"
" colorscheme hybrid

" onehalfdark {{{
silent! colorscheme onehalfdark

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

highlight Comment cterm=italic
highlight Normal guibg=NONE ctermbg=NONE
highlight NormalFloat guibg=NONE ctermbg=NONE
" }}}

" set t_Co=256
" let g:seoul256_srgb = 1

" ayu {{{
" set termguicolors     " enable true colors support
" let ayucolor="light"  " for light version of theme
" let ayucolor="mirage" " for mirage version of theme
" let ayucolor="dark"   " for dark version of theme
" colorscheme ayu
" }}}

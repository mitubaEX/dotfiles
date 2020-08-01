set termguicolors
syntax enable

" color
" let g:seoul256_background = 234
set background=dark

" colorscheme hybrid
" colorscheme purpura

" onehalfdark(my favorite) {{{
" silent! colorscheme onehalfdark
"
" if exists('+termguicolors')
"   let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"   let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
"   set termguicolors
" endif
"
" highlight Comment cterm=italic
" highlight Normal guibg=NONE ctermbg=NONE
" highlight NormalFloat guibg=NONE ctermbg=NONE
" }}}

" set t_Co=256
" let g:seoul256_srgb = 1

" embark {{{
" colorscheme embark
" let g:lightline = {
"      \ 'colorscheme': 'embark',
"      \ }
" }}}

" ayu {{{
" set termguicolors     " enable true colors support
" let ayucolor="light"  " for light version of theme
" let ayucolor="mirage" " for mirage version of theme
" let ayucolor="dark"   " for dark version of theme
" colorscheme ayu
" }}}

" gruvbox-material {{{
" if has('termguicolors')
" 	set termguicolors
" endif
"
" set background =dark
" let g:gruvbox_material_background = 'hard'
" let g:gruvbox_material_enable_italic = '1'
" let g:gruvbox_material_better_performance = 1
" let g:gruvbox_material_transparent_background = 1
" let g:gruvbox_material_diagnostic_line_highlight = 1
" let g:gruvbox_material_current_word = 'bold'
" let g:gruvbox_material_palette = 'original'
" colorscheme gruvbox-material
" }}}

" vim-moonfly-colors {{{
colorscheme moonfly
let g:moonflyTerminalColors = 0
" }}}

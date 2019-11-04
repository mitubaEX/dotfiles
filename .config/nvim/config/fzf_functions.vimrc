" fzf
nmap <Leader>t :Files<CR>
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" ctags
function! s:tagsCurrentWordQuery() abort
	let cword = expand("<cword>")
	execute "Tags " . cword
endfunction
command! -nargs=* TagsCurrentWordQuery call s:tagsCurrentWordQuery()

command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

" git grep
function! s:gGrepCurrentWordQuery() abort
	let cword = expand("<cword>")
	execute "GGrep " . cword
endfunction
command! -nargs=* GGrepCurrentWordQuery call s:gGrepCurrentWordQuery()
nmap <Leader>g :GGrepCurrentWordQuery<CR>

" rg
command! -bang -nargs=* Fg call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
function! s:rgCurrentWordQuery() abort
	let cword = expand("<cword>")
	execute "Fg " . cword
endfunction
command! -nargs=* RgCurrentWordQuery call s:rgCurrentWordQuery()
nmap <Leader>a :Fg<CR>

" 現在のウィンドウの半透明度を指定する。
set winblend=20
"
" ポップアップメニューの半透明度を指定する
set pumblend=30
" ref: https://kassioborges.dev/2019/04/10/neovim-fzf-with-a-floating-window.html
" Reverse the layout to make the FZF list top-down
let $FZF_DEFAULT_OPTS='--layout=reverse'

" Using the custom window creation function
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

" Function to create the custom floating window
function! FloatingFZF()
  " creates a scratch, unlisted, new, empty, unnamed buffer
  " to be used in the floating window
  let buf = nvim_create_buf(v:false, v:true)

  " 90% of the height
  let height = float2nr(&lines * 0.5)
  " 60% of the height
  let width = float2nr(&columns * 0.6)
  " horizontal position (centralized)
  let horizontal = float2nr((&columns - width) / 2)
  " vertical position (one line down of the top)
  let vertical = float2nr((&lines - height) / 2)

  let opts = {
	\ 'relative': 'editor',
	\ 'row': vertical,
	\ 'col': horizontal,
	\ 'width': width,
	\ 'height': height
	\ }

  " open the new window, floating, and enter to it
  call nvim_open_win(buf, v:true, opts)
endfunction

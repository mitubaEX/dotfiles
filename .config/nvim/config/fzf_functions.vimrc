" fzf
nmap <Leader>t :Files<CR>
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
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
function! s:rgCurrentWordQuery() abort
	let cword = expand("<cword>")
	execute "Rg " . cword
endfunction
command! -nargs=* RgCurrentWordQuery call s:rgCurrentWordQuery()
nmap <Leader>a :Rg<CR>

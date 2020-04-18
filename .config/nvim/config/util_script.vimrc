" rspec script
function! s:toggleRspecFile() abort
	let current_dir = expand('%:r')
  let basename = @%
  let filename = expand('%:t')
  if current_dir =~ 'spec'
    execute "e " . substitute(substitute(basename, filename, '', 'g'), 'spec', 'app', "g") . substitute(filename, '_spec.rb', '', 'g') . '.rb'
  else
    execute "e " . substitute(substitute(basename, filename, '', 'g'), 'app', 'spec', "g") . substitute(filename, '.rb', '', 'g') . '_spec.rb'
  endif
endfunction
command! -nargs=* ToggleRspecFile call s:toggleRspecFile()
nmap <Leader>x :ToggleRspecFile<CR>

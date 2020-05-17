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

" Require fugitive and .
" When open blame buffer of fugitive,
" execute command.
function! s:openCurrentBlameFile() abort
  let current_absolute_path = expand('%:p')
  if current_absolute_path =~ 'fugitive'
    let current_filehash = expand('%:t')
    let splited_filepath = split(expand('%:r'), '/')
    let owner_name = splited_filepath[-5]
    let repo_name = splited_filepath[-4]

    let joined_path = join([owner_name, repo_name, 'commit', current_filehash], '/')
    let open_url = 'https://github.com/' . joined_path

    execute 'OpenBrowser ' . open_url
  endif
endfunction
command! -nargs=* OpenCurrentBlameFile call s:openCurrentBlameFile()
nmap <Leader>b :OpenCurrentBlameFile<CR>

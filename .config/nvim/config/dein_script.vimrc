if &compatible
    set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.config/nvim/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.config/nvim')
    call dein#begin('~/.config/nvim')

    " Let dein manage dein
    " Required:
    call dein#add('~/.config/nvim/repos/github.com/Shougo/dein.vim')

    " Add or remove your plugins here:
    call dein#load_toml('~/plugins/dein.toml', {'lazy': 0})
    call dein#load_toml('~/plugins/dein_lang.toml', {'lazy': 1})
    call dein#load_toml('~/plugins/dein_denite.toml', {'lazy': 1})

    " conflict coc.nvim
    " call dein#load_toml('~/dein_lazy.toml', {'lazy': 1})
    if !has('nvim')
      call dein#add('roxma/nvim-yarp')
      call dein#add('roxma/vim-hug-neovim-rpc')
    endif

    call dein#end()
    call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

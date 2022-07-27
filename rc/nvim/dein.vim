"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin($HOME . '/.cache/dein')

" Let dein manage dein
" Required:
call dein#add($HOME . '/.cache/dein/repos/github.com/Shougo/dein.vim')

let s:toml_dir = stdpath('config')

" Add or remove your plugins here like this:
call dein#load_toml(s:toml_dir . '/dein.toml',     {'lazy': 0})
call dein#load_toml(s:toml_dir . '/deinlazy.toml', {'lazy': 1})
call dein#load_toml(s:toml_dir . '/ddc.toml',      {'lazy': 1})
call dein#load_toml(s:toml_dir . '/ddu.toml',      {'lazy': 1})
call dein#load_toml(s:toml_dir . '/view.toml',     {'lazy': 0})

" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------

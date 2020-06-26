" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

let s:init_dir='~/AppData/Local/nvim/'

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#load_toml(s:init_dir . '/dein.toml' ,{'lazy': 0})
  call dein#load_toml(s:init_dir . '/dein_lazy.toml' ,{'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

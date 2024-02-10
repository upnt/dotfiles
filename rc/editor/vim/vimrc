" keybind
inoremap jj <ESC>

" basic
set autoindent
set smartindent
set smarttab
set expandtab

set shiftwidth=4
set softtabstop=4
set tabstop=4

set scrolloff=5
set splitright

set noswapfile

filetype plugin indent on

" sound
set visualbell t_vb=
set noerrorbells

" view
set number
set cursorline
set hlsearch
colorscheme desert
syntax on

" Undo
if has('persistent_undo')
  let undo_path = expand('~/.cache/undo/vim')
  if !isdirectory(undo_path)
    call mkdir(undo_path, "p")
  endif
  exe 'set undodir=' . undo_path
  set undofile
endif

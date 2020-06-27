" options
let g:ruby_host_prog='C:\Ruby26-x64\bin\ruby.exe'

" plugin settings
if &compatible
  set nocompatible
endif

runtime! plug_manager.vim

filetype plugin indent on
syntax on

" mapping
let mapleader= "\<Space>" " for plugin mappings
inoremap<silent> jj <ESC>
nmap <Esc><Esc> :nohlsearch<CR>

" encording
set fileformats=unix,dos,mac
set fileencodings=utf-8,sjis

" search
set ignorecase
set smartcase
set incsearch
set hlsearch

" tabspace
set shiftwidth=4
set tabstop=4
set expandtab
set smartindent

augroup MyTabGroup
  au!
  au FileType tex setlocal shiftwidth=2
  au FileType tex setlocal tabstop=2
  au FileType plaintex setlocal shiftwidth=2
  au FileType plaintex setlocal tabstop=2
  au FileType html setlocal shiftwidth=2
  au FileType html setlocal tabstop=2
augroup END

" other options
set number
set ambiwidth=double
set showmatch
set wildmode=list:longest

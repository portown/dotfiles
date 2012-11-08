" .vimrc


set nocompatible


" -------------------------------------------------------------
" neobundle.vim の設定

filetype off

if has( 'vim_starting' )
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc( expand( '~/.vim/bundle' ) )

NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc', {
      \   'build' : {
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'unix' : 'make -f make_unix.mak',
      \   },
      \ }
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/unite.vim'

filetype plugin indent on

" -------------------------------------------------------------


set encoding=utf-8


set autoindent smartindent

set clipboard=unnamed

set tags=~/.tags

colorscheme ron

set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=0
set smarttab

set list
set listchars=tab:^\ ,trail:_,extends:<
highlight JpSpace cterm=underline ctermfg=Blue guibg=Blue
au BufNewFile,BufRead * match JpSpace /　/

set backspace=indent,start,eol

set showmatch

set number
set ruler

set ignorecase smartcase
set incsearch hlsearch
set wrapscan

set foldmethod=indent
set foldlevel=0

syntax on

let java_highlight_all=1
let java_highlight_debug=1
let java_space_errors=1
let java_highlight_functions=1

let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'


" EOF


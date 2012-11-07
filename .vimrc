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
\   },
\ }

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/neocomplcache'

filetype plugin indent on

" -------------------------------------------------------------


set autoindent
set smartindent

set clipboard=unnamed

set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=0

set list
set listchars=tab:>\ ,trail:_
highlight JpSpace cterm=underline ctermfg=Blue guibg=Blue
au BufNewFile,BufRead * match JpSpace /　/

set backspace=indent,start,eol

set showmatch

set number
set ruler

set wrapscan
set ignorecase
set smartcase
set incsearch
set hlsearch


syntax on


let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'


" EOF

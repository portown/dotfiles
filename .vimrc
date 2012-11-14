" .vimrc


" -------------------------------------------------------------
" 初期化 {{{

set nocompatible

let s:is_windows = has( 'win32' ) || has( 'win64' )

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" neobundle.vim の設定 {{{

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
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'tpope/vim-fugitive'

filetype plugin indent on

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" 文字コードの設定 {{{

set encoding=utf-8

if s:is_windows
  set termencoding=cp932
endif

scriptencoding utf-8

set fileformat=unix
set fileformats=unix,dos,mac

if exists( '&ambiwidth' )
  if has( 'kaoriya' )
    set ambiwidth=auto
  else
    set ambiwidth=double
  endif
endif

" }}}
" -------------------------------------------------------------

set autoindent smartindent

set clipboard=unnamed

set tags=~/.tags

colorscheme ron

" -------------------------------------------------------------
" タブ設定 {{{

set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=0
set smarttab

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" 空白文字の設定 {{{

set list
set listchars=tab:^\ ,trail:_,extends:<

" 全角スペースの表示 `　' ← これ
augroup JpSpace
  autocmd!
  autocmd ColorScheme * highlight JpSpace term=underline ctermbg=Blue guibg=Blue
  autocmd VimEnter,WinEnter * match JpSpace /\%u3000/
augroup END

" }}}
" -------------------------------------------------------------

set backspace=indent,start,eol

set showmatch

set number
set ruler

" -------------------------------------------------------------
" 検索設定 {{{

set ignorecase smartcase
set incsearch hlsearch
set wrapscan

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" 折り畳み設定 {{{

set foldmethod=marker
set foldlevel=0

" }}}
" -------------------------------------------------------------

syntax on

nnoremap <SPACE> <PageDown>

autocmd Filetype help nnoremap <buffer> q <C-w>c

" -------------------------------------------------------------
" Java の設定 {{{

let java_highlight_all=1
let java_highlight_debug=1
let java_space_errors=1
let java_highlight_functions=1

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" neocomplcache の設定 {{{

let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" VimFiler の設定 {{{

let g:vimfiler_as_default_explorer = 1

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" Unite.vim の設定 {{{

noremap <C-U><C-B> :Unite buffer<CR>

" }}}
" -------------------------------------------------------------


" EOF


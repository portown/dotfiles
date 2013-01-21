" .vimrc


" -------------------------------------------------------------
" 初期化 {{{

set nocompatible

let s:is_windows = has( 'win32' ) || has( 'win64' )

augroup Portown
  autocmd!
augroup END

" Go の設定
if $GOROOT != ''
  set rtp+=$GOROOT/misc/vim
endif

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
NeoBundle 'ujihisa/vimshell-ssh'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'tsukkee/unite-help'
NeoBundle 'Shougo/unite-ssh'
NeoBundle 'tpope/vim-surround'
NeoBundle 'kana/vim-tabpagecd'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'thinca/vim-logcat'
NeoBundle 'motemen/hatena-vim'
NeoBundle 'aklt/plantuml-syntax'
NeoBundle 'vim-scripts/sudo.vim.git'
NeoBundle 'vim-jp/cpp-vim'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'ujihisa/shadow.vim'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'tpope/vim-haml'

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

" -------------------------------------------------------------
" インデントの設定 {{{

set smartindent

set cinoptions+=l1,g0,t0
autocmd Portown Filetype c,cpp set cindent

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" タブ設定 {{{

nnoremap [tab] <Nop>
nmap <Leader>t [tab]

nnoremap [tab]n :<C-U>tabnew<CR>

" }}}
" -------------------------------------------------------------

set clipboard=unnamed

set tags=~/.tags

colorscheme ron

" -------------------------------------------------------------
" タブ文字設定 {{{

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

syntax enable

nnoremap <SPACE> <PageDown>
nnoremap Y y$

autocmd Portown Filetype help nnoremap <buffer> q <C-w>c

" -------------------------------------------------------------
" 保存時に行末スペースを消去 {{{

function! RTrim()
  let l:cursor_pos = getpos( '.' )
  %s/\s\+$//e
  call setpos( '.', l:cursor_pos )
endfunction

autocmd Portown BufWritePre * call RTrim()

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" C++ の設定 {{{

let s:uncrustify_cpp_config = expand( '~/.uncrustify.cfg' )
autocmd Portown BufWritePre *.c,*.h call Uncrustify( 'C', s:uncrustify_cpp_config )
autocmd Portown BufWritePre *.cpp,*.cxx,*.hpp,*.hxx call Uncrustify( 'CPP', s:uncrustify_cpp_config )

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" Java の設定 {{{

let java_highlight_all=1
let java_highlight_debug=1
let java_space_errors=1
let java_highlight_functions=1

autocmd Portown BufWritePre *.java call Uncrustify( 'JAVA', expand( '~/.uncrustify.java.cfg' ) )

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" Gradle の設定 {{{

autocmd BufRead,BufNewFile *.gradle set filetype=groovy

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

let g:neocomplcache_vim_completefuncs = {
      \   'Unite' : 'unite#complete_source',
      \   'VimShellExecute' : 'vimshell#vimshell_execute_complete',
      \   'VimShellInteractive' : 'vimshell#vimshell_execute_complete',
      \   'VimShellTerminal' : 'vimshell#vimshell_execute_complete',
      \   'VimShell' : 'vimshell#complete',
      \   'VimFiler' : 'vimfiler#complete',
      \ }

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" VimShell の設定 {{{

if s:is_windows
  let g:vimshell_prompt = $USERNAME.'@'.hostname().'$ '
else
  let g:vimshell_prompt = $USER.'$ '
endif

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" VimFiler の設定 {{{

let g:vimfiler_as_default_explorer = 1

nnoremap <silent> <Leader>fi :<C-U>VimFilerBufferDir -split -simple -winwidth=35 -no-quit<CR>

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" Unite.vim の設定 {{{

let g:unite_enable_start_insert = 1
let g:unite_kind_file_use_trashbox = 0

nnoremap [unite] <Nop>
nmap <C-U> [unite]

nnoremap [unite]<C-B> :<C-U>Unite buffer<CR>
nnoremap [unite]<C-F> :<C-U>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap [unite]<C-M> :<C-U>Unite file_mru<CR>
nnoremap [unite]<C-H> :<C-U>Unite help<CR>

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" hatena.vim の設定 {{{

let g:hatena_user = 'portown'

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" uncrustify の設定 {{{

let g:uncrustify_command = 'uncrustify'

function! Uncrustify( lang, config_file )
  if !executable( g:uncrustify_command ) || !filereadable( a:config_file )
    return
  endif

  let l:cursor_pos = getpos( '.' )
  :silent execute '%!uncrustify -q -l '.a:lang.' -c '.a:config_file
  call setpos( '.', l:cursor_pos )
endfunction

" }}}
" -------------------------------------------------------------

" 起動時のメッセージを表示しない
set shortmess+=I


" EOF


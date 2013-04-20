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
" ローカル設定の読み込み {{{

if filereadable( expand( '~/.vimrc.local.before' ) )
  source ~/.vimrc.local.before
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

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc', {
      \   'build' : {
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \   },
      \ }

" Unite
NeoBundle 'Shougo/unite.vim'
NeoBundle 'tsukkee/unite-help'
NeoBundle 'Shougo/unite-ssh'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'ryotakato/unite-outline-objc'
NeoBundle 'hewes/unite-gtags'

" Language
NeoBundle 'vim-jp/cpp-vim'
NeoBundle 'tpope/vim-haml'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'motemen/hatena-vim'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'aklt/plantuml-syntax'
NeoBundle 'vim-scripts/scons.vim'

" Others
NeoBundle 'Shougo/vimshell'
NeoBundle 'ujihisa/vimshell-ssh'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'anyakichi/vim-surround'
NeoBundle 'kana/vim-tabpagecd'
NeoBundle 'thinca/vim-logcat'
NeoBundle 'vim-scripts/sudo.vim.git'
NeoBundle 'ujihisa/shadow.vim'
NeoBundle 'hrsh7th/vim-versions'

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

nnoremap <silent> [tab]n :<C-U>tabnew<CR>

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" コマンドライン設定 {{{

nnoremap <SID>(command-line-enter) q:
xnoremap <SID>(command-line-enter) q:
nnoremap <SID>(command-line-norange) q:<C-U>

nmap : <SID>(command-line-enter)
xmap : <SID>(command-line-enter)

autocmd Portown CmdwinEnter * call s:init_cmdwin()
function! s:init_cmdwin()
  nnoremap <buffer> q :<C-U>quit<CR>
  nnoremap <buffer> <TAB> :<C-U>quit<CR>
  inoremap <buffer><expr> <CR> pumvisible() ? "\<C-Y>\<CR>" : "\<CR>"
  inoremap <buffer><expr> <C-H> pumvisible() ? "\<C-Y>\<C-H>" : "\<C-H>"
  inoremap <buffer><expr> <BS> pumvisible() ? "\<C-Y>\<C-H>" : "\<C-H>"

  inoremap <buffer><expr> <TAB> pumvisible() ? "\<C-N>" : "\<TAB>"

  startinsert!
endfunction

" }}}
" -------------------------------------------------------------

set clipboard=unnamed
set tags+=~/tags

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
set laststatus=2
set cmdheight=2
set showcmd

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
autocmd Portown Filetype help nnoremap <buffer> <C-]> :<C-U>tag <C-R><C-W><CR>

" -------------------------------------------------------------
" 保存時に行末スペースを消去 {{{

let g:portown_rtrim_enable = 1

function! RTrim()
  if !g:portown_rtrim_enable
    return
  endif

  let l:cursor_pos = getpos( '.' )
  %s/\s\+$//e
  call setpos( '.', l:cursor_pos )
endfunction

autocmd Portown BufWritePre * call RTrim()

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" Java の設定 {{{

let java_highlight_all=1
let java_highlight_debug=1
let java_space_errors=1
let java_highlight_functions=1

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" Gradle の設定 {{{

autocmd Portown BufRead,BufNewFile *.gradle set filetype=groovy

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" SCons の設定 {{{

autocmd Portown BufRead,BufNewFile SConstruct set filetype=scons

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

command! PortownVimShellSplit :topleft 10split

nnoremap [vimshell] <Nop>
nmap <Leader>s [vimshell]
nnoremap [vimshell]s :<C-U>VimShellBufferDir -buffer-name=shell -toggle -split -split-command=PortownVimShellSplit<CR>

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" VimFiler の設定 {{{

let g:vimfiler_as_default_explorer = 1

nnoremap [vimfiler] <Nop>
nmap <Leader>f [vimfiler]
nnoremap <silent> [vimfiler]f :<C-U>VimFilerBufferDir -buffer-name=explorer -direction=topleft -toggle -split -simple -winwidth=35 -no-quit<CR>

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" Unite.vim の設定 {{{

let g:unite_enable_start_insert = 1
let g:unite_kind_file_use_trashbox = 0

let g:unite_source_grep_default_opts = '-Hn'
let g:unite_source_grep_recursive_opt = '-r'

nnoremap [unite] <Nop>
nmap <Leader>u [unite]

nnoremap <silent> [unite]b :<C-U>Unite -buffer-name=buffers buffer_tab<CR>
nnoremap <silent> [unite]h :<C-U>Unite -buffer-name=help help<CR>
nnoremap <silent> [unite]o :<C-U>Unite -buffer-name=outline outline<CR>
nnoremap <silent> [unite]u :<C-U>UniteResume<CR>

nnoremap [unite-file] <Nop>
nmap [unite]f [unite-file]
nnoremap <silent> [unite-file]f :<C-U>Unite -buffer-name=files file file/new<CR>
nnoremap <silent> [unite-file]d :<C-U>UniteWithBufferDir -buffer-name=files file file/new<CR>
nnoremap <silent> [unite-file]r :<C-U>Unite -buffer-name=files file_rec/async<CR>
nnoremap <silent> [unite-file]m :<C-U>Unite -buffer-name=files file_mru<CR>
nnoremap <silent> [unite-file]b :<C-U>Unite -buffer-name=files bookmark<CR>

nnoremap [unite-gtags] <Nop>
nmap [unite]g [unite-gtags]
nnoremap <silent> [unite-gtags]r :<C-U>Unite gtags/ref<CR>
nnoremap <silent> <C-]> :<C-U>Unite -immediately -no-start-insert -no-quit -keep-focus -winheight=10 gtags/context<CR>

nnoremap [unite-neobundle] <Nop>
nmap [unite]n [unite-neobundle]
nnoremap <silent> [unite-neobundle]u :<C-U>Unite -no-start-insert -no-cursor-line -buffer-name=neobundle neobundle/update<CR>
nnoremap <silent> [unite-neobundle]c :<C-U>UniteClose neobundle<CR>

nnoremap [unite-versions] <Nop>
nmap [unite]v [unite-versions]
nnoremap <silent> [unite-versions]v :<C-U>UniteVersions<CR>
nnoremap <silent> [unite-versions]s :<C-U>UniteVersions status:!<CR>
nnoremap <silent> [unite-versions]l :<C-U>UniteVersions log:!<CR>

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

function! g:uncrustify( lang, config_file )
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

" -------------------------------------------------------------
" ローカル設定の読み込み {{{

if filereadable( expand( '~/.vimrc.local.after' ) )
  source ~/.vimrc.local.after
endif

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" ディレクトリローカルな設定の読み込み {{{

augroup vimrc-local
  autocmd!
  autocmd BufNewFile,BufReadPost * call s:vimrc_local( expand( '<afile>:p:h' ) )
augroup END

function! s:vimrc_local( location )
  let files = findfile( '.vimrc.local', escape( a:location, ' ' ) . ';', -1 )
  for i in reverse( filter( files, 'filereadable( v:val )' ) )
    source `=i`
  endfor
endfunction

" }}}
" -------------------------------------------------------------


" EOF


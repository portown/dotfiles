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
NeoBundleLazy 'Shougo/unite.vim', {
      \   'autoload' : { 'commands' : ['Unite', 'UniteResume', 'UniteWithBufferDir'] },
      \ }
NeoBundle 'thinca/vim-unite-history'
NeoBundle 'tsukkee/unite-help'
NeoBundle 'Shougo/unite-ssh'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'ryotakato/unite-outline-objc'
NeoBundle 'hewes/unite-gtags'

" Language
NeoBundleLazy 'vim-jp/cpp-vim', {
      \   'autoload' : { 'filetypes' : ['cpp'] }
      \ }
NeoBundle 'tpope/vim-haml'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'motemen/hatena-vim'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'aklt/plantuml-syntax'
NeoBundle 'vim-scripts/scons.vim'
NeoBundle 'ebnf.vim'
NeoBundle 'timcharper/textile.vim'
NeoBundle 'msanders/cocoa.vim'

" Others
NeoBundleLazy 'Shougo/vimshell', {
      \   'autoload' : { 'commands' : ['VimShellCurrentDir'] },
      \   'depends' : ['Shougo/vimproc'],
      \ }
NeoBundle 'ujihisa/vimshell-ssh'
NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/neosnippet'
NeoBundleLazy 'Shougo/vimfiler', {
      \   'autoload' : { 'commands' : ['VimFilerBufferDir'] },
      \   'depends' : ['Shougo/unite.vim'],
      \ }
NeoBundle 'anyakichi/vim-surround'
NeoBundleLazy 'thinca/vim-logcat', {
      \   'autoload' : { 'commands' : ['Logcat', 'Logcat!', 'LogcatClean'] },
      \ }
NeoBundle 'vim-scripts/sudo.vim.git'
NeoBundle 'ujihisa/shadow.vim'
NeoBundle 'hrsh7th/vim-versions'
NeoBundle 'w0ng/vim-hybrid'

filetype plugin indent on

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" 文字コードの設定 {{{

set encoding=utf-8

if s:is_windows
  set termencoding=cp932
endif

if has('kaoriya')
  set fileencodings=guess
else
  set fileencodings=ucs-bom,iso-2022-jp,euc-jp,cp932,utf-8

  " 日本語を含まない場合は fenc = enc
  function! RecheckIso2022Jp()
    if &fileencoding =~# 'iso-2022-jp' && search('[^\x01-\x7e]', 'n') == 0
      let &fileencoding = &encoding
    endif
  endfunction
  autocmd Portown BufReadPost * call RecheckIso2022Jp()
endif

scriptencoding utf-8

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

nnoremap <SID>[tab] <Nop>
nmap <Leader>t <SID>[tab]

nnoremap <silent> <SID>[tab]n :<C-U>tabnew<CR>

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
  nnoremap <silent> <buffer> q :<C-U>quit<CR>
  inoremap <silent> <buffer><expr> <CR> pumvisible() ? "\<C-Y>\<CR>" : "\<CR>"
  inoremap <silent> <buffer><expr> <C-H> col('.') == 1 ? "\<ESC>:q\<CR>" : pumvisible() ? "\<C-Y>\<C-H>" : "\<C-H>"
  inoremap <silent> <buffer><expr> <BS> col('.') == 1 ? "\<ESC>:q\<CR>" : pumvisible() ? "\<C-Y>\<C-H>" : "\<C-H>"

  inoremap <silent> <buffer><expr> <TAB> pumvisible() ? "\<C-N>" : "\<TAB>"

  startinsert!
endfunction

" }}}
" -------------------------------------------------------------

if has('unnamedplus')
  set clipboard=unnamedplus
else
  set clipboard=unnamed
endif

set tags+=~/tags

colorscheme hybrid

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
  if !g:portown_rtrim_enable || ( exists( 'b:portown_rtrim_enable' ) && !b:portown_rtrim_enable )
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
" EBNF の設定 {{{

autocmd Portown BufRead,BufNewFile *.ebnf set filetype=ebnf

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" neocomplete の設定 {{{

let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" neosnippet の設定 {{{

imap <C-K> <Plug>(neosnippet_expand_or_jump)
smap <C-K> <Plug>(neosnippet_expand_or_jump)
xmap <C-K> <Plug>(neosnippet_expand_target)

imap <expr><Tab> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \: pumvisible() ? "\<C-N>" : "\<Tab>"
smap <expr><Tab> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \: "\<Tab>"

if has( 'conceal' )
  set conceallevel=2
  set concealcursor=i
endif

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" VimShell の設定 {{{

let s:bundle = neobundle#get('vimshell')
function! s:bundle.hooks.on_source(bundle)
  if s:is_windows
    let g:vimshell_prompt = $USERNAME.'@'.hostname().'$ '
  else
    let g:vimshell_prompt = $USER.'$ '
  endif
endfunction

command! PortownVimShellSplit :topleft 10split

nnoremap <SID>[vimshell] <Nop>
nmap <Leader>s <SID>[vimshell]
nnoremap <silent> <SID>[vimshell]s :<C-U>VimShellCurrentDir -buffer-name=shell -toggle -split -split-command=PortownVimShellSplit<CR>
nnoremap <silent> <SID>[vimshell]f :<C-U>VimShellCurrentDir -buffer-name=shell<CR>

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" VimFiler の設定 {{{

let s:bundle = neobundle#get('vimfiler')
function! s:bundle.hooks.on_source(bundle)
endfunction

nnoremap <SID>[vimfiler] <Nop>
nmap <Leader>f <SID>[vimfiler]
nnoremap <silent> <SID>[vimfiler]e :<C-U>VimFilerBufferDir -buffer-name=explorer -direction=topleft -toggle -split -simple -winwidth=35 -no-quit<CR>
nnoremap <silent> <SID>[vimfiler]f :<C-U>VimFilerBufferDir -buffer-name=explorer<CR>
nnoremap <silent> <SID>[vimfiler]d :<C-U>VimFilerBufferDir -double<CR>

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" Unite.vim の設定 {{{

let s:bundle = neobundle#get('unite.vim')
function! s:bundle.hooks.on_source(bundle)
  let g:unite_enable_start_insert = 0
  let g:unite_kind_file_use_trashbox = 0

  let g:unite_source_grep_default_opts = '-Hn'
  let g:unite_source_grep_recursive_opt = '-r'
endfunction

nnoremap <SID>[unite] <Nop>
nmap <Leader>u <SID>[unite]

nnoremap <silent> <SID>[unite]b :<C-U>Unite -buffer-name=buffers -start-insert buffer_tab<CR>
nnoremap <silent> <SID>[unite]h :<C-U>Unite -buffer-name=help -start-insert help<CR>
nnoremap <silent> <SID>[unite]o :<C-U>Unite -buffer-name=outline -start-insert outline<CR>
nnoremap <silent> <SID>[unite]u :<C-U>UniteResume<CR>

nnoremap <SID>[unite-file] <Nop>
nmap <SID>[unite]f <SID>[unite-file]
nnoremap <silent> <SID>[unite-file]f :<C-U>Unite -buffer-name=files -start-insert file file/new<CR>
nnoremap <silent> <SID>[unite-file]d :<C-U>UniteWithBufferDir -buffer-name=files -start-insert file file/new<CR>
nnoremap <silent> <SID>[unite-file]r :<C-U>Unite -buffer-name=files -start-insert file_rec/async<CR>
nnoremap <silent> <SID>[unite-file]m :<C-U>Unite -buffer-name=files -start-insert file_mru<CR>
nnoremap <silent> <SID>[unite-file]b :<C-U>Unite -buffer-name=files -start-insert bookmark<CR>

nnoremap <SID>[unite-gtags] <Nop>
nmap <SID>[unite]g <SID>[unite-gtags]
nnoremap <silent> <SID>[unite-gtags]r :<C-U>Unite -immediately -no-quit -keep-focus -winheight=10 gtags/ref<CR>
nnoremap <silent> <C-]> :<C-U>Unite -immediately -no-quit -keep-focus -winheight=10 gtags/context<CR>

nnoremap <SID>[unite-neobundle] <Nop>
nmap <SID>[unite]n <SID>[unite-neobundle]
nnoremap <silent> <SID>[unite-neobundle]u :<C-U>Unite -buffer-name=neobundle -no-cursor-line -log neobundle/update<CR>
nnoremap <silent> <SID>[unite-neobundle]c :<C-U>UniteClose neobundle<CR>

nnoremap <SID>[unite-versions] <Nop>
nmap <SID>[unite]v <SID>[unite-versions]
nnoremap <silent> <SID>[unite-versions]v :<C-U>UniteVersions<CR>
nnoremap <silent> <SID>[unite-versions]s :<C-U>UniteVersions status:!<CR>
nnoremap <silent> <SID>[unite-versions]l :<C-U>UniteVersions log:!<CR>

nnoremap q: :<C-U>Unite -buffer-name=commands -winheight=8 -direction=botright history/command<CR>
xnoremap q: :<C-U>Unite -buffer-name=commands -winheight=8 -direction=botright history/command<CR>

nnoremap q/ :<C-U>Unite -buffer-name=commands -winheight=8 -direction=botright history/search<CR>
xnoremap q/ :<C-U>Unite -buffer-name=commands -winheight=8 -direction=botright history/search<CR>

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


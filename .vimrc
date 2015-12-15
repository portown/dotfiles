" .vimrc

set encoding=utf-8
scriptencoding utf-8

" -------------------------------------------------------------
" 初期化 {{{

let s:is_windows = has('win32') || has('win64')
let s:is_mac = has('mac')

augroup Portown
    autocmd!
augroup END

" Go の設定
if $GOROOT != ''
    if has('vim_starting')
        set rtp+=$GOROOT/misc/vim
    endif
endif

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" ローカル設定の読み込み {{{

if filereadable(expand('~/.vimrc.local.before'))
    source ~/.vimrc.local.before
endif

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" neobundle.vim の設定 {{{

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle'))

" Core
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc', {
            \       'build' : {
            \           'windows' : 'echo "Sorry, cannot update vimproc binary file in Windows."',
            \           'cygwin' : 'make -f make_cygwin.mak',
            \           'mac' : 'make -f make_mac.mak',
            \           'unix' : 'make -f make_unix.mak',
            \       },
            \   }

" Unite
NeoBundle 'Shougo/unite.vim'
NeoBundleLazy 'Shougo/neomru.vim', {
            \   'depends': 'Shougo/unite.vim',
            \   'autoload': {
            \     'unite_sources': ['neomru/file', 'neomru/directory'],
            \   },
            \ }
NeoBundleLazy 'thinca/vim-unite-history', {
            \   'depends': 'Shougo/unite.vim',
            \   'autoload': {
            \     'unite_sources': ['history/command', 'history/search'],
            \   },
            \ }
NeoBundleLazy 'Shougo/unite-help', {
            \   'depends': 'Shougo/unite.vim',
            \   'autoload': {
            \     'unite_sources': 'help',
            \   },
            \ }
NeoBundleLazy 'Shougo/unite-ssh', {
            \   'depends': 'Shougo/unite.vim',
            \   'autoload': {
            \     'unite_sources': 'ssh',
            \   },
            \ }
NeoBundleLazy 'Shougo/unite-outline', {
            \   'depends': 'Shougo/unite.vim',
            \   'autoload': {
            \     'unite_sources': 'outline',
            \   },
            \ }
NeoBundleLazy 'ryotakato/unite-outline-objc', {
            \   'depends': ['Shougo/unite.vim', 'Shougo/unite-outline'],
            \   'autoload': {
            \     'filetypes': 'objc',
            \   },
            \ }
NeoBundleLazy 'hewes/unite-gtags', {
            \   'depends': 'Shougo/unite.vim',
            \   'autoload': {
            \     'unite_sources': ['gtags/ref', 'gtags/context'],
            \   },
            \ }
NeoBundleLazy 'Shougo/unite-build', {
            \   'depends': 'Shougo/unite.vim',
            \   'autoload': {
            \     'unite_sources': 'build',
            \   },
            \ }
NeoBundleLazy 'thinca/vim-ref', {
            \   'depends': 'Shougo/unite.vim',
            \   'autoload': {
            \     'unite_sources': 'ref',
            \   },
            \ }

" Language
NeoBundleLazy 'vim-jp/cpp-vim', {
            \   'autoload': { 'filetypes': ['cpp', 'objcpp'] },
            \ }
NeoBundleLazy 'tpope/vim-haml', {
            \   'autoload': { 'filename_patterns': '\.haml$' },
            \ }
NeoBundleLazy 'kchmck/vim-coffee-script', {
            \   'autoload': { 'filename_patterns': '\.coffee$' },
            \ }
NeoBundleLazy 'plasticboy/vim-markdown', {
            \   'autoload': { 'filename_patterns': '\.md$' },
            \ }
NeoBundleLazy 'aklt/plantuml-syntax', {
            \   'autoload': { 'filename_patterns': '\.p\%(lant\)\?uml$' },
            \ }
NeoBundleLazy 'vim-scripts/scons.vim', {
            \   'autoload': { 'filename_patterns': 'SConstruct$' },
            \ }
NeoBundleLazy 'ebnf.vim', {
            \   'autoload': { 'filename_patterns': '\.ebnf$' },
            \ }
NeoBundleLazy 'timcharper/textile.vim', {
            \   'autoload': { 'filename_patterns': '\.textile$' },
            \ }
NeoBundleLazy 'jam.vim', {
            \   'autoload': { 'filename_patterns': '\%(\.jam\|Jamfile\|Jamroot\)$' },
            \ }
NeoBundleLazy 'groovyindent', {
            \   'autoload': { 'filetypes': ['groovy'] },
            \ }
NeoBundleLazy 'udalov/kotlin-vim', {
            \   'autoload': { 'filename_patterns': '\%(\.kt\|\.kts\)$' },
            \ }
NeoBundleLazy 'dag/vim2hs', {
            \   'autoload': { 'filetypes': ['haskell'] },
            \ }
NeoBundleLazy 'eagletmt/ghcmod-vim', {
            \       'autoload': { 'filetypes': ['haskell'] },
            \   }
NeoBundleLazy 'honza/dockerfile.vim', {
            \   'autoload': { 'filename_patterns': 'Dockerfile$' },
            \ }
NeoBundleLazy 'https://fedorapeople.org/cgit/wwoods/public_git/vim-scripts.git', {
            \   'autoload': { 'filename_patterns': '\%(\.service\)$' },
            \ }
if s:is_mac
    NeoBundleLazy 'b4winckler/vim-objc', {
                \       'autoload': { 'filetypes': ['objc', 'objcpp'] }
                \   }
    NeoBundleLazy 'toyamarinyon/vim-swift', {
            \   'autoload': { 'filename_patterns': '\.swift' },
            \ }
endif
NeoBundleLazy 'jvoorhis/coq.vim', {
            \       'autoload': { 'filename_patterns': '\.v$' },
            \   }
NeoBundleLazy 'vim-scripts/CoqIDE', {
            \       'autoload': { 'filetypes': ['coq'] },
            \   }
NeoBundleLazy 'PProvost/vim-ps1', {
            \       'autoload': { 'filename_patterns': '\.ps1$' },
            \   }

" Textobjs
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-textobj-entire', {
            \   'depends': 'kana/vim-textobj-user',
            \ }
NeoBundle 'kana/vim-textobj-line', {
            \   'depends': 'kana/vim-textobj-user',
            \ }
NeoBundle 'thinca/vim-textobj-between', {
            \   'depends': 'kana/vim-textobj-user',
            \ }
NeoBundle 'h1mesuke/textobj-wiw', {
            \   'depends': 'kana/vim-textobj-user',
            \ }
NeoBundle 'anyakichi/vim-textobj-xbrackets', {
            \   'depends': 'kana/vim-textobj-user',
            \ }
NeoBundle 'osyo-manga/vim-textobj-multiblock', {
            \   'depends': 'kana/vim-textobj-user',
            \ }
NeoBundle 'rhysd/vim-textobj-ruby', {
            \       'depends': 'kana/vim-textobj-user',
            \   }

" Operators
NeoBundle 'kana/vim-operator-user'
NeoBundle 'kana/vim-operator-replace', {
            \   'depends': 'kana/vim-operator-user',
            \ }
NeoBundle 'rhysd/vim-operator-surround', {
            \   'depends': 'kana/vim-operator-user',
            \ }

" Completions
NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/neosnippet'
if s:is_mac
    NeoBundle 'Rip-Rip/clang_complete'
    NeoBundle 'tokorom/clang_complete-getopts-ios'
endif
NeoBundle 'eagletmt/neco-ghc', {
            \       'external_commands': ['ghc-mod'],
            \   }

" Others
NeoBundle 'vim-jp/vital.vim'
NeoBundle 'Shougo/tabpagebuffer.vim'
NeoBundleLazy 'Shougo/vimshell', {
            \   'autoload': { 'commands': ['VimShellCurrentDir'] },
            \   'depends': ['Shougo/vimproc'],
            \ }
NeoBundleLazy 'ujihisa/vimshell-ssh', {
            \   'autoload': { 'commands': ['VimShellCurrentDir'] },
            \   'depends': ['Shougo/vimshell'],
            \ }
NeoBundleLazy 'Shougo/vimfiler', {
            \   'autoload': { 'commands': ['VimFilerBufferDir'] },
            \   'depends': ['Shougo/unite.vim'],
            \ }
NeoBundleLazy 'thinca/vim-logcat', {
            \   'autoload': {
            \       'commands': ['Logcat', 'Logcat!', 'LogcatClear'],
            \       'filetypes': 'logcat',
            \       'filename_patterns': '\.logcat$'
            \   },
            \   'external_commands': 'adb',
            \ }
NeoBundle 'vim-scripts/sudo.vim.git'
NeoBundle 'ujihisa/shadow.vim'
NeoBundle 'itchyny/landscape.vim'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'cohama/agit.vim'
NeoBundle 'rhysd/committia.vim'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'kana/vim-smartinput'
NeoBundle 'thinca/vim-localrc'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'rhysd/conflict-marker.vim'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'fuenor/qfixgrep'
NeoBundle 'fuenor/qfixhowm'

call neobundle#end()

filetype plugin indent on
syntax enable

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" 文字コードの設定 {{{

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

set fileformats=unix,dos,mac

if exists('&ambiwidth')
    if has('kaoriya') && s:is_windows && has('gui_running')
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

set cinoptions& cinoptions+=l1,g0,t0
autocmd Portown Filetype c,cpp setlocal cindent

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" タブ設定 {{{

set showtabline=2

nnoremap <SID>[tab] <Nop>
nmap <Space>t <SID>[tab]

nnoremap <silent> <SID>[tab]n :<C-U>tabnew<CR>

nnoremap <C-N> gt
nnoremap <C-P> gT

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" コマンドライン設定 {{{

nnoremap <SID>(command-line-enter) q:
xnoremap <SID>(command-line-enter) q:
nnoremap <SID>(command-line-norange) q:<C-U>

nmap ; <SID>(command-line-enter)
xmap ; <SID>(command-line-enter)

autocmd Portown CmdwinEnter * call s:init_cmdwin()
function! s:init_cmdwin()
    nnoremap <silent> <buffer> q :<C-U>quit<CR>
    inoremap <silent> <buffer><expr> <CR> neocomplete#cancel_popup()."\<CR>"
    inoremap <silent> <buffer><expr> <C-H> col('.') == 1 ? "\<ESC>:q\<CR>" : neocomplete#cancel_popup()."\<C-H>"

    inoremap <silent> <buffer><expr> <TAB> pumvisible() ? "\<C-N>" : "\<TAB>"

    startinsert!
endfunction

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" クリップボード設定 {{{

if has('unnamedplus')
    set clipboard=unnamedplus
else
    set clipboard=unnamed
endif

" }}}
" -------------------------------------------------------------

set tags& tags+=~/tags

" -------------------------------------------------------------
" カラースキームの設定 {{{

if neobundle#is_installed('landscape.vim')
    function! MyVimrcConfigColorscheme()
        colorscheme landscape

        " landscape.vim に ModeMsg が設定されていないので設定
        highlight ModeMsg gui=bold guifg=fg
    endfunction

    if s:is_windows && has('gui_running')
        execute 'autocmd Portown GUIEnter * call MyVimrcConfigColorscheme()'
        execute 'autocmd Portown GUIEnter * call lightline#colorscheme()'
    else
        call MyVimrcConfigColorscheme()
    endif
endif

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" タブ文字設定 {{{

set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=0
set smarttab

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" 空白文字の設定 {{{

set list

let s:listchars = {
            \   'tab': '^ ',
            \   'trail': '_',
            \   'extends': '»',
            \   'precedes': '«',
            \ }
let &listchars = join(map(items(s:listchars), 'join(v:val, ":")'), ',')
unlet s:listchars

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" lightline の設定 {{{

let g:lightline = {
            \   'colorscheme': 'wombat',
            \   'active': {
            \     'left': [['mode'], ['fugitive', 'filename']],
            \     'right': [['syntastic', 'lineinfo'], ['fileformat', 'fileencoding', 'filetype']],
            \   },
            \   'inactive': {
            \     'left': [['filename']],
            \     'right': [['fileformat', 'fileencoding', 'filetype']],
            \   },
            \   'tabline': {
            \     'left': [['tabs']],
            \     'right': [['cwd']],
            \   },
            \   'component': {
            \     'lineinfo': '%3l/%{line("$")}:%-2v',
            \   },
            \   'component_function': {
            \     'fugitive': 'MyFugitive',
            \     'filename': 'MyFilename',
            \     'fileformat': 'MyFileformat',
            \     'filetype': 'MyFiletype',
            \     'fileencoding': 'MyFileencoding',
            \     'mode': 'MyMode',
            \     'cwd': 'MyCwd',
            \   },
            \   'component_expand': {
            \     'syntastic': 'SyntasticStatuslineFlag',
            \   },
            \   'component_type': {
            \     'syntastic': 'error',
            \   },
            \   'separator': { 'left': "\u2b80", 'right': "\u2b82" },
            \   'subseparator': { 'left': "\u2b81", 'right': "\u2b83" },
            \ }

function! MyFugitive()
    if &filetype !~? 'unite\|vimfiler' && exists("*fugitive#head")
        let _ = fugitive#head()
        return strlen(_) ? "\u2b60 "._ : ''
    endif
    return ''
endfunction

function! MyModified()
    if &modifiable && &modified
        return '+'
    else
        return ''
    endif
endfunction

function! MyReadonly()
    if &modifiable && &readonly
        return "\u2b64"
    else
        return ''
    endif
endfunction

function! MyModifiable()
    return &modifiable ? '' : "\u2718"
endfunction

function! MyFilename()
    return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
                \ (&ft ==# 'vimfiler' ? vimfiler#get_status_string() :
                \  &ft ==# 'unite' ? unite#get_status_string() :
                \  &ft ==# 'vimshell' ? vimshell#get_status_string() :
                \  '' != expand('%:t') ? expand('%:t') : '[No Name]') .
                \ ('' != MyModified() ? ' ' . MyModified() : '') .
                \ ('' != MyModifiable() ? ' ' . MyModifiable() : '')
endfunction

function! MyFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
    return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
    return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! MyCwd()
    return fnamemodify(getcwd(), ':~')
endfunction

" }}}
" -------------------------------------------------------------

set backspace=indent,start,eol

set showmatch

set laststatus=2
set cmdheight=2
set showcmd

set directory-=.

set ttyfast
set lazyredraw

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

nnoremap <Space><Space> <PageDown>
nnoremap Y y$

"nnoremap ; :
nnoremap : ;

cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

autocmd Portown Filetype help nnoremap <buffer> q <C-w>c
autocmd Portown Filetype help nnoremap <buffer> <C-]> :<C-U>tag <C-R><C-W><CR>

" -------------------------------------------------------------
" vim-smartinput {{{

call smartinput#map_to_trigger('i', '<Plug>(smartinput_CR)', '<CR>', '<CR>')
call smartinput#map_to_trigger('i', '<Plug>(smartinput_C-H)', '<BS>', '<C-H>')

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" Java の設定 {{{

let java_highlight_all = 1
let java_highlight_debug = 1
let java_space_errors = 1
let java_highlight_functions = 1

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" Haskell の設定 {{{

let g:haskell_conceal = 0

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
" m4 の設定 {{{

call smartinput#define_rule({
      \   'at': '\%#',
      \   'char': '`',
      \   'input': "`'<Left>",
      \   'filetype': ['m4'],
      \ })
call smartinput#define_rule({
      \   'at': "`\%#'",
      \   'char': "'",
      \   'input': '<Right>',
      \   'filetype': ['m4'],
      \ })
call smartinput#define_rule({
      \   'at': "`\%#'",
      \   'char': '<BS>',
      \   'input': '<Del><BS>',
      \   'filetype': ['m4'],
      \ })

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" neocomplete の設定 {{{

let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_fuzzy_completion = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#auto_completion_start_length = 2
let g:neocomplete#manual_completion_start_length = 0
let g:neocomplete#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

let g:neocomplete#enable_auto_select = 1
let g:neocomplete#enable_refresh_always = 0

let g:neocomplete#sources#dictionary#dictionaries = {
            \   'default': '',
            \   'vimshell': $HOME.'/.vimshell/command-history',
            \ }

let g:neocomplete#enable_auto_delimiter = 1
let g:neocomplete#enable_auto_close_preview = 1

if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns._ = '\h\w*'

let g:neocomplete#force_overwrite_completefunc = 1
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
let s:omni_c = '[^.[:digit:] *\t]\%(\.\|->\)'
let s:omni_cpp = s:omni_c.'\|\h\w*::'
let s:omni_objc_specific = '\[\|\[[^.[:digit:] *\t]* \|\] '
let g:neocomplete#force_omni_input_patterns.objc = s:omni_c . '\|' . s:omni_objc_specific
let g:neocomplete#force_omni_input_patterns.objcpp = s:omni_cpp . '\|' . s:omni_objc_specific
unlet s:omni_c s:omni_cpp s:omni_objc_specific

if !exists('g:neocomplete#sources#file_include#exts')
    let g:neocomplete#sources#file_include#exts = {}
endif
let g:neocomplete#sources#file_include#exts.objc = ['h']

if !exists('g:neocomplete#sources#include#patterns')
    let g:neocomplete#sources#include#patterns = {}
endif
let g:neocomplete#sources#include#patterns.objc = '^\s*#\s*import'
let g:neocomplete#sources#include#patterns.objcpp = '^\s*#\s*import'

let g:neocomplete#sources#vim#complete_functions = {
            \   'Ref': 'ref#complete',
            \   'Unite': 'unite#complete_source',
            \   'VimShellExecute': 'vimshell#vimshell_execute_complete',
            \   'VimShellInteractive': 'vimshell#vimshell_execute_complete',
            \   'VimShellTerminal': 'vimshell#vimshell_execute_complete',
            \   'VimShell': 'vimshell#complete',
            \   'VimFiler': 'vimfiler#complete',
            \ }

inoremap <expr><C-F> pumvisible() ? "\<PageDown>" : "\<Right>"
inoremap <expr><C-B> pumvisible() ? "\<PageUp>" : "\<Left>"
inoremap <expr><C-Y> pumvisible() ? neocomplete#close_popup() : "\<C-R>\""
inoremap <expr><C-E> pumvisible() ? neocomplete#cancel_popup() : "\<End>"
imap <expr><C-H> neocomplete#smart_close_popup() . "\<Plug>(smartinput_C-H)"
inoremap <expr><C-N> pumvisible() ? "\<C-N>" : "\<C-X>\<C-U>\<C-P>\<Down>"
inoremap <expr><C-P> pumvisible() ? "\<C-P>" : "\<C-P>\<C-N>"

inoremap <expr><C-G> neocomplete#undo_completion()
inoremap <expr><C-L> neocomplete#complete_common_string()

imap <expr><CR> neocomplete#smart_close_popup() . "\<Plug>(smartinput_CR)"

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" clang_complete {{{

let g:clang_complete_auto = 0
let g:clang_auto_select = 0

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" neosnippet の設定 {{{

imap <C-K> <Plug>(neosnippet_expand)
smap <C-K> <Plug>(neosnippet_expand)
xmap <C-K> <Plug>(neosnippet_expand_target)

imap <expr><Tab> neosnippet#jumpable() ?
            \ "\<Plug>(neosnippet_jump)"
            \: pumvisible() ? "\<C-N>" : "\<Tab>"
smap <expr><Tab> neosnippet#jumpable() ?
            \ "\<Plug>(neosnippet_jump)"
            \: "\<Tab>"

if has('conceal')
    set conceallevel=2
    set concealcursor=i
endif

if !exists('g:neosnippet#snippets_directory')
    let g:neosnippet#snippets_directory = ''
endif
let g:neosnippet#snippets_directory = join([
            \   '~/.vim/snippets',
            \ ], ',')

if !exists('g:neosnippet#disable_runtime_snippets')
    let g:neosnippet#disable_runtime_snippets = {}
endif
let g:neosnippet#disable_runtime_snippets._ = 1

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" VimShell の設定 {{{

let s:hooks = neobundle#get_hooks('vimshell')
function! s:hooks.on_source(bundle)
    if s:is_windows
        let g:vimshell_prompt = $USERNAME.'@'.hostname().'$ '
    else
        let g:vimshell_prompt = $USER.'$ '
    endif
endfunction
unlet s:hooks

command! PortownVimShellSplit :topleft 10split

nnoremap <SID>[vimshell] <Nop>
nmap <Space>s <SID>[vimshell]
nnoremap <silent> <SID>[vimshell]s :<C-U>VimShellCurrentDir -buffer-name=shell -toggle -split -split-command=PortownVimShellSplit<CR>
nnoremap <silent> <SID>[vimshell]f :<C-U>VimShellCurrentDir -buffer-name=shell<CR>

autocmd Portown FileType vimshell execute 'nunmap <buffer> <C-N>' | nunmap <buffer> <C-P>

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" VimFiler の設定 {{{

let s:hooks = neobundle#get_hooks('vimfiler')
function! s:hooks.on_source(bundle)
    let g:vimfiler_force_overwrite_statusline = 0
endfunction
unlet s:hooks

nnoremap <SID>[vimfiler] <Nop>
nmap <Space>f <SID>[vimfiler]
nnoremap <silent> <SID>[vimfiler]e :<C-U>VimFilerBufferDir -buffer-name=explorer -direction=topleft -toggle -split -simple -winwidth=35 -no-quit<CR>
nnoremap <silent> <SID>[vimfiler]f :<C-U>VimFilerBufferDir -buffer-name=explorer<CR>
nnoremap <silent> <SID>[vimfiler]d :<C-U>VimFilerBufferDir -double<CR>

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" Unite.vim の設定 {{{

let s:file_patterns_to_be_ignored =
            \ '\%(^\|/\)\.$'
            \ . '\|\~$'
            \ . '\|\.\%(o\|exe\|dll\|bak\|DS_Store\|zwc\|pyc\|sw[po]\|class\|jar\|png\|gif\|jpe\?g\|fugitiveblame\)$'
            \ . '\|\%(^\|/\)\%(\.hg\|\.git\|\.bzr\|\.svn\|tags\%(-.*\)\?\)\%($\|/\)'

let s:hooks = neobundle#get_hooks('unite.vim')
function! s:hooks.on_source(bundle)
    let g:unite_enable_start_insert = 0
    let g:unite_kind_file_use_trashbox = 0

    let g:unite_force_overwrite_statusline = 0

    let g:unite_source_process_enable_confirm = 0

    call unite#custom#source('file_rec', 'ignore_pattern', s:file_patterns_to_be_ignored)
    call unite#custom#source('file_rec/async', 'ignore_pattern', s:file_patterns_to_be_ignored)
    call unite#custom#source('grep', 'ignore_pattern', s:file_patterns_to_be_ignored)

    if executable('pt')
        let g:unite_source_grep_command = 'pt'
        let g:unite_source_grep_default_opts = '--nocolor --nogroup'
        let g:unite_source_grep_recursive_opt = ''
    else
        let g:unite_source_grep_default_opts = '-Hn'
        let g:unite_source_grep_recursive_opt = '-r'
    endif

    if !exists('g:unite_source_alias_aliases')
        let g:unite_source_alias_aliases = {}
    endif
    let g:unite_source_alias_aliases.message = {
                \   'source': 'output',
                \   'args': 'message',
                \ }
    call unite#custom#source('message', 'sorters', 'sorter_reverse')
endfunction
unlet s:hooks

let s:hooks = neobundle#get_hooks('neomru.vim')
function! s:hooks.on_source(bundle)
    call unite#custom#source('neomru/file', 'ignore_pattern', s:file_patterns_to_be_ignored)
endfunction
unlet s:hooks

nnoremap <SID>[unite] <Nop>
nmap <Space>u <SID>[unite]

nnoremap <silent> <SID>[unite]b :<C-U>Unite -buffer-name=buffers -start-insert buffer_tab<CR>
nnoremap <silent> <SID>[unite]h :<C-U>Unite -buffer-name=help -start-insert -immediately -no-empty help<CR>
nnoremap <silent> <SID>[unite]o :<C-U>Unite -buffer-name=outline -start-insert outline<CR>
if executable('grep')
    nnoremap <silent> <SID>[unite]g :<C-U>Unite -buffer-name=grep -no-quit grep:.<CR>
else
    nnoremap <silent> <SID>[unite]g :<C-U>Unite -buffer-name=grep -no-quit vimgrep:**<CR>
endif
nnoremap <silent> <SID>[unite]u :<C-U>UniteResume<CR>

nnoremap <SID>[unite-file] <Nop>
nmap <SID>[unite]f <SID>[unite-file]
nnoremap <silent> <SID>[unite-file]f :<C-U>Unite -buffer-name=files -start-insert file file/new directory/new<CR>
nnoremap <silent> <SID>[unite-file]d :<C-U>UniteWithBufferDir -buffer-name=files -start-insert file file/new directory/new<CR>
if s:is_windows
    nnoremap <silent> <SID>[unite-file]r :<C-U>Unite -buffer-name=files -start-insert file_rec<CR>
else
    nnoremap <silent> <SID>[unite-file]r :<C-U>Unite -buffer-name=files -start-insert file_rec/async<CR>
endif
nnoremap <silent> <SID>[unite-file]m :<C-U>Unite -buffer-name=files -start-insert neomru/file<CR>
nnoremap <silent> <SID>[unite-file]b :<C-U>Unite -buffer-name=files -start-insert -default-action=lcd bookmark<CR>

nnoremap <SID>[unite-gtags] <Nop>
nmap <SID>[unite]t <SID>[unite-gtags]
nnoremap <silent> <SID>[unite-gtags]r :<C-U>Unite -immediately -no-quit -keep-focus -winheight=10 gtags/ref<CR>
nnoremap <silent> <C-]> :<C-U>Unite -immediately -no-quit -keep-focus -winheight=10 gtags/context<CR>

nnoremap <SID>[unite-neobundle] <Nop>
nmap <SID>[unite]n <SID>[unite-neobundle]
nnoremap <silent> <SID>[unite-neobundle]u :<C-U>Unite -buffer-name=neobundle -no-cursor-line -log neobundle/update<CR>
nnoremap <silent> <SID>[unite-neobundle]i :<C-U>Unite -buffer-name=neobundle -no-cursor-line -log neobundle/install<CR>
nnoremap <silent> <SID>[unite-neobundle]c :<C-U>UniteClose neobundle<CR>

function! PortownBuild(...)
    let clean = a:0 >= 1 ? a:1 : 0

    let base = 'Unite -buffer-name=build -winheight=8 -direction=botright -no-quit -no-focus build'

    let builder = ''
    if exists('b:portown_build_builder')
        let builder = b:portown_build_builder
    endif

    let args = []
    if exists('b:portown_build_args')
        let args = split(b:portown_build_args)
    endif

    if clean
        if exists('b:portown_build_clean_args')
            let args = add(args, split(args.b:portown_build_clean_args))
        else
            let args = add(args, 'clean')
        endif
    endif

    execute join([base, builder, join(args, '\\ ')], ':')
endfunction

" build の b は buffer と被る……
nnoremap <SID>[unite-make] <Nop>
nmap <SID>[unite]m <SID>[unite-make]
nnoremap <silent> <SID>[unite-make]m :<C-U>call PortownBuild()<CR>
nnoremap <silent> <SID>[unite-make]c :<C-U>call PortownBuild(1)<CR>
nnoremap <silent> <SID>[unite-make]q :<C-U>UniteClose build<CR>

nnoremap <SID>[unite-history] <Nop>
nmap <SID>[unite]i <SID>[unite-history]
nnoremap <silent> <SID>[unite-history]c :<C-U>Unite -buffer-name=commands -winheight=8 -direction=botright history/command<CR>
xnoremap <silent> <SID>[unite-history]c :<C-U>Unite -buffer-name=commands -winheight=8 -direction=botright history/command<CR>
nnoremap <silent> <SID>[unite-history]s :<C-U>Unite -buffer-name=commands -winheight=8 -direction=botright history/search<CR>
xnoremap <silent> <SID>[unite-history]s :<C-U>Unite -buffer-name=commands -winheight=8 -direction=botright history/search<CR>

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" vim-ref の設定 {{{

let s:hooks = neobundle#get_hooks('vim-ref')
function! s:hooks.on_source(bundle)
    let g:ref_source_webdict_sites = {
                \   'wikipedia:ja': {
                \     'url': 'http://ja.wikipedia.org/wiki/%s',
                \     'keyword_encoding': 'utf-8',
                \     'cache': 1,
                \   },
                \   'wiktionary': {
                \     'url': 'http://ja.wiktionary.org/wiki/%s',
                \     'keyword_encoding': 'utf-8',
                \     'cache': 1,
                \   },
                \ }
    function! g:ref_source_webdict_sites.wiktionary.filter(output)
        return join(split(a:output, "\n")[18 :], "\n")
    endfunction

    let g:ref_source_webdict_sites.default = 'wiktionary'
endfunction
unlet s:hooks

autocmd Portown FileType ref-webdict nnoremap <buffer> q <C-W>c

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" uncrustify の設定 {{{

let g:uncrustify_command = 'uncrustify'

function! Uncrustify(lang, config_file)
    if !executable(g:uncrustify_command) || !filereadable(a:config_file)
        return
    endif

    let l:cursor_pos = getpos('.')
    :silent execute '%!uncrustify -q -l '.a:lang.' -c '.a:config_file
    call setpos('.', l:cursor_pos)
endfunction

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" fugitive.vim の設定 {{{

nnoremap <SID>[git] <Nop>
nmap <Space>g <SID>[git]
nnoremap <SID>[git]d :<C-U>Gvdiff<CR>
nnoremap <SID>[git]s :<C-U>Gstatus<CR>
nnoremap <SID>[git]cc :<C-U>Gcommit -v<CR>
nnoremap <SID>[git]ca :<C-U>Gcommit -av<CR>
nnoremap <SID>[git]b :<C-U>Gblame<CR>

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" agit.vim の設定 {{{

let g:agit_enable_auto_show_commit = 1
let g:agit_enable_auto_refresh = 0

nnoremap <SID>[agit] <Nop>
nmap <SID>[git]v <SID>[agit]
nnoremap <silent> <SID>[agit]v :<C-U>Agit<CR>
nnoremap <silent> <SID>[agit]f :<C-U>AgitFile<CR>

autocmd Portown filetype agit nnoremap <buffer> git :<C-U>AgitGit 

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" Vim Git Gutter の設定 {{{

let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" Syntastic {{{

let g:syntastic_mode_map = { 'mode': 'passive' }

function! MyVimrcSyntastic()
    SyntasticCheck
    call lightline#update()
endfunction

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" vim-textobj-multiblock {{{

let g:textobj#multiblock#default_blocks = []
let g:textobj_multiblock_blocks = [
            \   ['"', '"', 1],
            \   ["'", "'", 1],
            \   ['`', '`', 1],
            \   ['(', ')'],
            \   ['{', '}'],
            \   ['[', ']'],
            \   ['<', '>'],
            \ ]

let g:textobj#multiblock#enable_block_in_cursor = 1

omap ab <Plug>(textobj-multiblock-a)
omap ib <Plug>(textobj-multiblock-i)
xmap ab <Plug>(textobj-multiblock-a)
xmap ib <Plug>(textobj-multiblock-i)

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" vim-operator-surround {{{

nmap <silent>ys <Plug>(operator-surround-append)
nmap <silent>csb <Plug>(operator-surround-replace)<Plug>(textobj-multiblock-a)
nmap <silent>csc <Plug>(operator-surround-replace)<Plug>(textobj-between-a)
nmap <silent>dsb <Plug>(operator-surround-delete)<Plug>(textobj-multiblock-a)
nmap <silent>dsc <Plug>(operator-surround-delete)<Plug>(textobj-between-a)

xmap <silent>s <Plug>(operator-surround-append)

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" vim-operator-replace {{{

nmap <silent>_ <Plug>(operator-replace)

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" QuickRun {{{

let g:quickrun_config = {}

let g:quickrun_config._ = {
            \       'runner': 'vimproc',
            \       'runner/vimproc/updatetime': 60,
            \       'outputter': 'error',
            \       'outputter/error/success': 'buffer',
            \       'outputter/error/error': 'quickfix',
            \   }

let g:quickrun_config.haskell = {
            \       'command': 'runghc',
            \   }

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" QFixHowm {{{

let howm_dir = '~/howm'
let howm_filename = '%Y/%m/%Y-%m-%d-%H%M%S.md'
let QFixHowm_RootDir = howm_dir
let QFixHowm_FileType = 'markdown'
let QFixHowm_Title = '#'
let QFixMRU_Title = {}
let QFixMRU_Title['md'] = '^#[^#]'
let QFixHowm_HolidayFile = $HOME . '.vim/bundle/qfixhowm/misc/holiday/Sche-Hd-0000-00-00-000000.utf8'

let QFixHowm_ScheduleSearchDir = howm_dir . '/schedule'
let QFixHowm_ScheduleSearchFile = ''

" }}}
" -------------------------------------------------------------

" 起動時のメッセージを表示しない
set shortmess& shortmess+=I

" -------------------------------------------------------------
" .vimrc の設定 {{{

nnoremap <SID>[vimrc] <Nop>
nmap <Space>v <SID>[vimrc]

nnoremap <silent> <SID>[vimrc]e :<C-U>edit $MYVIMRC<CR>
nnoremap <silent> <SID>[vimrc]l :<C-U>source $MYVIMRC \| if has('gui_running') \| source $MYGVIMRC \| endif<CR>

" .gvimrc の編集は CUI/GUI 関係なくコマンドでできるようにする
nnoremap <SID>[gvimrc] <Nop>
nmap <SID>[vimrc]g <SID>[gvimrc]

nnoremap <silent> <SID>[gvimrc]e :<C-U>edit $MYGVIMRC<CR>

" .gvimrc の再読み込みは GUI のみ
if has('gui_running')
    nnoremap <silent> <SID>[gvimrc]l :<C-U>source $MYGVIMRC<CR>
endif

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" ローカル設定の読み込み {{{

if filereadable(expand('~/.vimrc.local.after'))
    source ~/.vimrc.local.after
endif

" }}}
" -------------------------------------------------------------

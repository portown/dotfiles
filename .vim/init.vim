" init.vim

set encoding=utf-8
scriptencoding utf-8

" -------------------------------------------------------------
" 初期化 {{{

let s:is_windows = has('win32') || has('win64')
let s:is_mac = has('mac')

function! IsWindows()
    return s:is_windows
endfunction

function! IsMac()
    return s:is_mac
endfunction

function! s:source_rc(path)
    execute 'source' fnameescape(expand('~/.vim/rc/' . a:path))
endfunction

augroup Portown
    autocmd!
augroup END

" Go の設定
if $GOROOT != ''
    if has('vim_starting')
        set rtp+=$GOROOT/misc/vim
    endif
endif

let g:vimproc#download_windows_dll = 1

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
" dein.vim の設定 {{{

if has('vim_starting')
    set runtimepath^=~/.vim/bundle/repos/github.com/Shougo/dein.vim/
endif

let s:dein_path = expand('~/.vim/bundle')
let s:toml_path = '~/.vim/dein.toml'
let s:toml_lazy_path = '~/.vim/deinlazy.toml'
if dein#load_state(s:dein_path)
    call dein#begin(s:dein_path, [expand('<sfile>'), s:toml_path, s:toml_lazy_path])

    call dein#load_toml(s:toml_path, {'lazy': 0})
    call dein#load_toml(s:toml_lazy_path, {'lazy': 1})
    call dein#local('~/.vim', {'frozen': 1}, ['local'])

    call dein#end()
    call dein#call_hook('source')
    call dein#save_state()

    if dein#check_install()
        call dein#install()
    endif
endif
autocmd VimEnter * call dein#call_hook('post_source')

filetype plugin indent on
syntax enable

" Because of confliction against syntax/unite.vim in unite.vim,
" landscape.vim must be loaded lazily.
call dein#source('landscape.vim')

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" 文字コードの設定 {{{

if IsWindows()
    set termencoding=cp932
endif

set fileencodings=ucs-bom,utf-8
set fileformats=unix,dos,mac

if exists('&ambiwidth')
    if has('kaoriya') && IsWindows() && has('gui_running')
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
    startinsert!
endfunction

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" Backspace configurations {{{

function! PortownBackspace()
    if bufname('%') ==# '[Command Line]' && col('.') == 1
        return "\<ESC>q"
    endif

    let ret = ''
    if dein#tap('deoplete.nvim')
        let ret = ret . deoplete#mappings#smart_close_popup()
    elseif dein#tap('neocomplete.vim')
        let ret = ret . neocomplete#smart_close_popup()
    endif

    if dein#tap('vim-smartinput')
        let ret = ret . "\<Plug>(smartinput_C-H)"
    else
        let ret = "\<BS>"
    endif

    return ret
endfunction

imap <silent><expr> <C-H> PortownBackspace()
imap <silent><expr> <BS> PortownBackspace()

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

if dein#tap('landscape.vim')
    function! MyVimrcConfigColorscheme()
        colorscheme landscape

        " landscape.vim に ModeMsg が設定されていないので設定
        highlight ModeMsg gui=bold guifg=fg
    endfunction

    if IsWindows() && has('gui_running')
        autocmd Portown GUIEnter * call MyVimrcConfigColorscheme() | call lightline#colorscheme()
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

set backspace=indent,start,eol

set showmatch

set laststatus=2
set cmdheight=2
set showcmd

set directory-=.

set lazyredraw

set diffopt=filler,vertical

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
" Java の設定 {{{

let java_highlight_all = 1
let java_highlight_debug = 1
let java_space_errors = 1
let java_highlight_functions = 1

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

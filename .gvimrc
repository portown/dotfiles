" .gvimrc


let s:is_windows = has( 'win32' ) || has( 'win64' )


" GUI 用のカラースキームを設定（こちらで設定しないと反映されない）
colorscheme torte

" -------------------------------------------------------------
" ウィンドウ設定 {{{

" 起動時にウィンドウ最大化
autocmd GUIEnter * simalt ~x

" ツールバーとメニューバーを消す
set guioptions-=T
set guioptions-=m

" タイトルを固定する
set titlestring=gVim

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" フォント設定 {{{

if s:is_windows
  set guifont=Migu\ 1M:h11:cSHIFTJIS
else
  set guifont=Migu\ 1M\ 11
endif

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" 日本語入力設定 {{{

" 日本語入力オン時のカーソル色を変更する
highlight CursorIM guibg=Red

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" マウス設定 {{{

set nomousefocus
set mousehide

" }}}
" -------------------------------------------------------------

" 起動時のメッセージを表示しない
set shortmess+=I


" EOF


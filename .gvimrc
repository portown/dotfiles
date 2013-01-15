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

" スクロールバーを消す
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R

" タイトルを固定する
set titlestring=gVim

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" タブ設定 {{{

" タブ名設定関数
function! GuiTabLabel()
  let l:label = ''

  let l:buflist = tabpagebuflist( v:lnum )

  let l:bufname = fnamemodify( bufname( l:buflist[tabpagewinnr( v:lnum ) - 1] ), ':t' )
  let l:label .= ( l:bufname == '' ? 'No title' : l:bufname )

  " 変更されたバッファがあるかチェック
  for buf in l:buflist
    if getbufvar( buf, '&modified' )
      let label .= '[+]'
      break
    endif
  endfor

  return l:label
endfunction

" タブ番号と共にタブ名を表示させる
set guitablabel=%N:\ %{GuiTabLabel()}

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


" EOF


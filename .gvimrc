" .gvimrc


let s:is_windows = has( 'win32' ) || has( 'win64' )


" GUI 用のカラースキームを設定（こちらで設定しないと反映されない）
colorscheme hybrid

" -------------------------------------------------------------
" ウィンドウ設定 {{{

" 起動時にウィンドウ最大化
if s:is_windows
  autocmd Portown GUIEnter * simalt ~x
elseif has( 'gui_macvim' )
  set lines=999 columns=9999
else
  autocmd Portown GUIEnter * winpos 0 0
  set lines=59
  set columns=239
endif

set guioptions&

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
  set guifont=Ricty:h12:cSHIFTJIS

  if exists( '&rop' )
    " DirectWrite の設定
    "   pixelGeometry: RGB
    "   renderingMode: NATURAL_SYMMETRIC
    "   textAntialiasMode: CLEARTYPE
    set rop=type:directx,gamma:1.7,contrast:1.0,level:0.8,geom:1,renmode:5,taamode:1
  endif
elseif has('gui_gtk2')
  set guifont=Ricty\ 12
else
  set guifont=Ricty:h16
endif

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" 日本語入力設定 {{{

" 日本語入力オン時のカーソル色を変更する
highlight CursorIM guibg=Red

set iminsert=0
set imsearch=0

" }}}
" -------------------------------------------------------------

" -------------------------------------------------------------
" マウス設定 {{{

set mouse=
set nomousefocus
set mousehide

" }}}
" -------------------------------------------------------------

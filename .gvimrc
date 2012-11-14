" .gvimrc


au GUIEnter * simalt ~x


colorscheme torte


set guioptions-=T
set guioptions-=m

set titlestring=gVim


if has( 'win32' ) || has( 'win64' )
  set guifont=Migu\ 1M:h11:cSHIFTJIS
else
  set guifont=Migu\ 1M\ 11
endif


set nomousefocus
set mousehide


" EOF


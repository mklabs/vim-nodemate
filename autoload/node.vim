" node.vim -    Library script for node-buddy
" Maintainer:   mklabs

if exists("g:autoloaded_node") || v:version < 700 || &cp
  finish
endif
let g:autoloaded_node = 1

function! node#hello()
  echo "Fooooo"
endfunction


" vim:set sw=2 sts=2:


" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

" XXX add configuration option to prefix mapping with user defined
inoremap <expr> <buffer> <C-Space> nodemate#triggerCompl()
inoremap <expr> <buffer> <C-X><C-U> nodemate#triggerCompl()

" command! -buffer nodemateCompletion call nodemate#enableCompl()
call nodemate#enableCompl()

" vim:set sw=2 sts=2:

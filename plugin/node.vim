" node.vim -    The vim node buddy
" Maintainer:   mklabs

if exists("g:loaded_node") || v:version < 700 || &cp
  finish
endif

let g:loaded_node = 1

"  ____________
" < Hello Node >
"  ------------
"         \    ,-^-.
"          \   !oYo!
"           \ /./=\.\______
"                ##        )\/\
"                 ||-----w||
"                 ||      ||
"
"                Cowth Vader
"


" kickstart the universe
function! s:InitNodeBuddy()

  "
  " Should implement in a reliable way some kind of node project
  " detection. Presence of package.json is a good indicator, but not
  " exclusive.
  "
  " Another approach is to define a command or mapping to trigger
  " manually by user to activate the plugin functionnality.
  "

  " easier find (XXX browse, and find how vim-rails does it, there's
  " some awesome path finding and navigation in there)

  " set extension to also look for .js / .coffee files
  "
  " :let &suffixesadd = '.js,.coffee'

  " Add relevant paths to the 'path' (used with :find and gf)
  " pretty arbitrary path for now, and should append instead of replace. This
  " mess up with other plugins that might have changed this.
  "
  " Plus the initizalition is always right now, should be done only on
  " node-based project
  "
  " :let &path = 'bin/,lib/,test/'

  call s:InitMappings()
endfunction


" that's a mess right now. Rework
function! s:NodeFind()
  let file = expand('<cfile>')

  if filereadable(file)
    return s:edit(file)
  endif

  let file = file . '.js'
  if filereadable(file)
    return s:edit(file)
  endif

  " look for relative thing, should check that file begins with "."
  let current = fnamemodify(expand('%'), ':h')
  let file = fnamemodify(file, ':t')
  let relative = join([current, file], '/')

  " and if it's not relative, and not part of node core module...
  " Should spawn a node process and resolve this file, and jump to it
  if filereadable(relative)
    return s:edit(relative)
  endif

  " that works for pretty simple stuff (in tests/) but should do the
  " relativize thing in a more reliable way. Untill I learn how to do this
  " properly in Vim, will probably do the heavy crafting of path finding and
  " all by spawning a node process
  "
  " Goal of jumping to bar.js from foo.js when gf-ing from require('./bar') is
  " ok, but that's pretty much all it does...


  " here a little more complicated stuff to find things
  " .... todo ...
endfunction

function! s:edit(file)
  exe 'edit' a:file
endfunction

function! s:InitMappings()
  " not sure here...
  nnoremap <Plug>NodeFind       :call <SID>NodeFind()<CR>
  if !hasmapto("<Plug>NodeFind")
    nmap gf <Plug>NodeFind
  endif
endfunction

call s:InitNodeBuddy()

" vim:set sw=2 sts=2:


if exists("g:loaded_nodematemate") || v:version < 700 || &cp
  " finish
endif
let g:loaded_nodematemate = 1

" Object.create like prototype-like create
let s:Object = {}
function! s:Object.create(...)
  let F = copy(self)
  if a:0
    let F = extend(self, a:1)
  endif
  return F
endfunction

" Utilities
function! s:has(line, pat)
  let m = matchstr(a:line, a:pat)
  return m != ""
endfunction

function! s:map(list, prefix)
  return map(copy(a:list), 'a:prefix . v:val')
endfunction

function! s:trim(str)
  return substitute(a:str, '^\s*\(.\{-}\)\s*$', '\1', '')
endfunction


" nodemate app prototype
let s:base = {}
let s:base.basedir = expand('<sfile>:h:h')
let s:base.completer = join([s:base.basedir, 'bin/completer'], '/')

function! s:base.compl(findstart, base)
  let line = getline('.')
  if a:findstart
    let existing = matchstr(line[0:col('.')-1], '\.\w*$')
    return col('.') - 1 - strlen(existing)
  endif

  return self.complete(line)
endfunction

function! s:base.complete(line)
  let parts = split(a:line, '\.')
  let module = s:trim(parts[0])
  let property = len(parts)  > 1 ? parts[1] : ''
  let basedir = self.basedir . '/snippets/javascript/' . module
  let pattern = basedir . '/*.snippet'
  let files = split(glob(pattern), '\n')

  " if we have a prop, then filter the snippets
  if property != ''
    let files = filter(files, 'fnamemodify(v:val, ":t:r") =~ "^' . property . '"')
  endif

  let results = []
  for filepath in files
    let filename = fnamemodify(filepath, ':t:r')
    let info = join(readfile(filepath), '\n')

    " if we have a prop, then substitute it from the completion results, so
    " that we don't append it. else, simply append the leading .
    let word = property == '' ? '.' . filename : substitute(filename, property, '', '')

    let results += [{
      \ 'word': word,
      \ 'abbr': '.' . filename,
      \ 'menu': module . '#' . filename,
      \ 'info': info
    \}]
  endfor

  " todo: set options to bypass lookup based on snippets, always go through
  " require.resolve / require(). This is significantly slower, but the preview
  " window will output the functions source, which can be incredibly handy,
  " even for node core methods.

  " let results = []

  if !len(results)
    let bufferdir = expand('%:h')
    let resolved = system('cd ' . bufferdir . ' && node -pe "require.resolve(\"' . module . '\")"')
    if resolved =~ 'Cannot find'
      return results
    endif

    let keys = split(system('cd ' . bufferdir . ' && node -pe "Object.keys(require(\"' . module . '\")).join(\"\n\")"'), '\n')
    for key in keys
      let word = '.' . key

      if property != ''
        let keys = filter(keys, 'fnamemodify(v:val, ":t:r") =~ "^' . property . '"')
        let word = substitute(filename, property, '', '')
      endif

      let results += [{
        \ 'word': word,
        \ 'abbr': '.' . key,
        \ 'menu': module . '#' . key,
        \ 'info': system('cd ' . bufferdir . ' && node -pe "var obj = require(\"' . module . '\")[\"' . key . '\"]; typeof obj === \"function\" ? obj + \"\" : require(\"util\").inspect(obj, true, 2)"')
      \}]
    endfor
  endif

  return results
endfunction

let s:nodemate = s:Object.create(s:base)

function! nodemate#app()
  return s:nodemate
endfunction

" Public API
function! nodemate#compl(findstart, base)
  return s:nodemate.compl(a:findstart, a:base)
endfunction

" helper to check if a given line is suitable for nodemate completion
function! nodemate#complete(...)
  let line = a:0 ? a:1 : getline('.')

  let files = split(glob(s:nodemate.basedir . '/snippets/javascript/*'), '\n')
  let core = filter(files, "isdirectory(v:val)")
  let core = map(core, "fnamemodify(v:val, ':t')")

  let ok = 0
  for module in core
    if !ok
      let ok = s:has(line, module . '\.\?\w*$')
    endif
  endfor

  if !ok
    " nok for node core, try require.resolve-ing it
    let parts = split(line, '\.')
    let module = parts[0]
    let resolved = system('node -pe "require.resolve(\"' . module . '\")"')
    if resolved !~ 'Cannot find'
      let ok = 1
    endif
  endif

  return ok
endfunction

function! nodemate#triggerCompl()
  let line = getline('.')
  let dotend = s:has(line, '\.$')

  if nodemate#complete(line)
    let prefix = dotend ? '' : '.'
    return prefix . "\<C-X>\<C-U>"
  endif
  return ''
endfunction

function! nodemate#enableCompl()
  setlocal completefunc=nodemate#compl
  setlocal omnifunc=nodemate#compl
endfunction

" vim:set sw=2 sts=2:


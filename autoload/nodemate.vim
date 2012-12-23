if exists("g:loaded_nodematemate") || v:version < 700 || &cp
  finish
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
  let module = parts[0]
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


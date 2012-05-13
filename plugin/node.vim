" node.vim -    I ♥ Node. That's pretty much it.
" Maintainer:   @mklabs
" Version:      0.0.1

if exists("g:loaded_node") || v:version < 700 || &cp
  finish
endif
let g:loaded_node = 1

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
  return matchstr(a:line, a:pat) != ''
endfunction

function! s:map(list, prefix)
  return map(copy(a:list), 'a:prefix . v:val')
endfunction

" node app prototype

let s:nodeproto = {}
let s:nodeproto.basedir = expand('<sfile>:h:h')
let s:nodeproto.completer = join([s:nodeproto.basedir, 'bin/completer'], '/')

function! s:nodeproto.compl(findstart, base)
  let line = getline('.')
  if a:findstart
    let existing = matchstr(line[0:col('.')-1], '\.\w*$')
    return col('.') - 1 - strlen(existing)
  endif

  return self.complete(line)
endfunction

function! s:nodeproto.complete(line)
  let out = system('node ' . self.completer . ' "' . a:line . '"')
  return split(out, "\n")
endfunction


let s:node = s:Object.create(s:nodeproto)


function! node#app()
  return s:node
endfunction

" Public API
function! node#compl(findstart, base)
  return s:node.compl(a:findstart, a:base)
endfunction

" helper to check if a given line is suitable for node completion
function! node#complete(...)
  let line = a:0 ? a:1 : getline('.')

  let core = [
    \ 'assert', 'buffer', 'child_process', 'cluster', 'console',
    \ 'constants', 'crypto', 'dgram', 'dns', 'events', 'freelist',
    \ 'fs', 'http', 'https', 'module', 'net', 'os', 'path',
    \ 'punycode', 'querystring', 'readline', 'repl', 'stream', 'string_decoder',
    \ 'sys', 'timers', 'tls', 'tty', 'url', 'util', 'vm', 'zlib'
  \ ]

  let ok = 0
  for module in core
    if !ok
      let ok = s:has(line, module . '\.\?\w*$')
    endif
  endfor

  return ok
endfunction

function! node#triggerCompl()
  let line = getline('.')
  let dotend = s:has(line, '\.$')
  if node#complete(line)
    let prefix = dotend ? '' : '.'
    setlocal completefunc=node#compl
    return prefix . "\<C-X>\<C-U>"
  endif
  return ''
endfunction


" XXX add configuration option to prefix mapping with user defined
autocmd FileType javascript inoremap <expr> <buffer> <C-Space> node#triggerCompl()

" this.foo

" vim:set sw=2 sts=2:

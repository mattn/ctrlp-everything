if exists('g:loaded_ctrlp_everything') && g:loaded_ctrlp_everything
  finish
endif
let g:loaded_ctrlp_everything = 1

function s:match(item)
  let str = a:item['str']
  if len(str) <= 3
    throw "too short"
  endif
  
  return split(system(printf('es -a-d %s', shellescape(str))), "\n")
endfunction

let s:everything_var = {
\  'init':   'ctrlp#everything#init()',
\  'accept': 'ctrlp#everything#accept',
\  'lname':  'everything',
\  'sname':  'everything',
\  'matcher':  {'match': function('s:match'), 'arg_type': 'dict'},
\  'type':   'path',
\  'sort':   0,
\  'nolim':  1,
\}

if exists('g:ctrlp_ext_vars') && !empty(g:ctrlp_ext_vars)
  let g:ctrlp_ext_vars = add(g:ctrlp_ext_vars, s:everything_var)
else
  let g:ctrlp_ext_vars = [s:everything_var]
endif

function! ctrlp#everything#init()
  return []
endfunc

function! ctrlp#everything#accept(mode, str)
  call ctrlp#exit()
  call ctrlp#acceptfile(a:mode, a:str)
endfunction

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
function! ctrlp#everything#id()
  return s:id
endfunction

" vim:fen:fdl=0:ts=2:sw=2:sts=2



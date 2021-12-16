" ============================================================
" Filename: switchname.vim
" Author: yuxki
" License: MIT License
" Last Change: 2021/12/15 23:27:13
" ============================================================

let s:save_cpo = &cpo
set cpo&vim

function! switchname#SwitchName(to_case)
  let s:line = getline('.')
  let s:name_poses = switchname#get#GetNamesInLine(s:line)
  let s:index = switchname#get#GetNamePosIndexOnCursor(s:name_poses)

  if s:index < 0
    return
  endif

  " adjust __member and __NAME__ naming patterns
  let s:name = s:name_poses[s:index][0]

  let s:prefix_pos = matchstrpos(s:name, '^_\+')
  if s:prefix_pos[1] >= 0
    let s:name = s:name[s:prefix_pos[2]:]
  endif

  let s:sufix_pos = matchstrpos(s:name, '_\+$')
  if s:sufix_pos[1] >= 0
    let s:name = s:name[:s:sufix_pos[1] - 1]
  endif

  let s:repl = s:prefix_pos[0] . switchname#convert#ConvertName(s:name, a:to_case) . s:sufix_pos[0]
  return s:repl
endfunction

function! switchname#SetName(repl, line)
  let s:name_poses = switchname#get#GetNamesInLine(a:line)
  let s:index = switchname#get#GetNamePosIndexOnCursor(s:name_poses)
  if :s:name_poses[s:index][1] - 1 >= 0
    let s:repl_line = a:line[0:s:name_poses[s:index][1] - 1] . a:repl . a:line[s:name_poses[s:index][2]:]
  else
    let s:repl_line = a:repl . a:line[s:name_poses[s:index][2]:]
  endif
  call setline('.', s:repl_line)
endfunction

function! s:IsStrInList(list, str)
  for elem in a:list
    if match(elem, a:str.'\C') >= 0
      return 1
    endif
  endfor
  return 0
endfunction

function! switchname#OpenSwitchMenu()
  let s:cases = [
        \  'UpperCamelCase',
        \ 'lowerCamelCase',
        \ 'UPPER_SNAKE_CASE',
        \ 'lower_snake_case',
        \ 'UPPER-KEBAB-CASE',
        \ 'lower-kebab-case',
        \ ]

  let s:repls = []
  let s:repl_choices = []
  let s:idx = 0
  for c in s:cases
    let s:r = switchname#SwitchName(c)
    if !s:IsStrInList(s:repls, s:r)
      call add(s:repls, s:r)
      call add(s:repl_choices, string(s:idx) . '.'. s:r)
      let s:idx += 1
    endif
  endfor

  function! __SwitchNameFilter(winid, key)
    if a:key =~# '\d' && a:key >= 0 && a:key < s:idx
      call switchname#SetName(s:repls[a:key], getline('.'))
    endif
    call popup_close(a:winid)
    return 0
  endfunction

  call popup_atcursor(s:repl_choices,
        \#{
        \ close: 'button',
        \ highlight: 'Pmenu',
        \ padding: [0, 2, 0, 2],
        \ filter: '__SwitchNameFilter',
        \ })
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

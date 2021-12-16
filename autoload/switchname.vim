" ============================================================
" Filename: switchname.vim
" Author: yuxki
" License: MIT License
" Last Change: 2021/12/15 23:27:13
" ============================================================

let s:save_cpo = &cpo
set cpo&vim

function! switchname#SetName(repl, line, pos)
  if a:pos[1] - 1 >= 0
    let s:repl_line = a:line[0:a:pos[1] - 1] . a:repl . a:line[a:pos[2]:]
  else
    let s:repl_line = a:repl . a:line[a:pos[1][2]:]
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
  let s:line = getline('.')
  let s:name_poses = switchname#get#GetNamesInLine(s:line)
  let s:index = switchname#get#GetNamePosIndexOnCursor(s:name_poses)

  if s:index < 0
    return
  endif

  let s:name = s:name_poses[s:index][0]

  let s:cases = [
        \  'UpperCamelCase',
        \ 'lowerCamelCase',
        \ 'UPPER_SNAKE_CASE',
        \ 'lower_snake_case',
        \ 'UPPER-KEBAB-CASE',
        \ 'lower-kebab-case',
        \ ]

  let s:repls = []
  let s:repl_options = []
  let s:repls_index = 0
  for cs in s:cases
    let s:repl = switchname#switch#SwitchName(s:name, cs)
    if !s:IsStrInList(s:repls, s:repl)
      call add(s:repls, s:repl)
      call add(s:repl_options, string(s:repls_index) . '.'. s:repl)
      let s:repls_index += 1
    endif
  endfor

  function! __SwitchNameFilter(winid, key)
    if a:key =~# '\d' && a:key >= 0 && a:key < s:repls_index
      call switchname#SetName(s:repls[a:key], s:line, s:name_poses[s:index])
      call popup_close(a:winid)
    endif
    return 1
  endfunction

  call popup_atcursor(s:repl_options,
        \#{
        \ title: ' --switch name-- ',
        \ highlight: 'Pmenu',
        \ padding: [0, 2, 0, 2],
        \ filter: '__SwitchNameFilter',
        \ })
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

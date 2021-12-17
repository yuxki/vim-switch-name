" ============================================================
" Filename: get.vim
" Author: yuxki
" License: MIT License
" Last Change: 2021/12/15 23:27:32
" ============================================================

let s:save_cpo = &cpo
set cpo&vim

function! switchname#name#GetPosIndexOnCursor(name_poses)
  let s:curpos_row_inline = getcurpos()[2] - 1
  let s:index = 0
  for name_pos in a:name_poses
    if name_pos[1] <= s:curpos_row_inline && s:curpos_row_inline < name_pos[2]
      return s:index
    endif
  let s:index += 1
  endfor
  return -1
endfunction

function! switchname#name#GetPosesInLine(line)
  let s:start = 0
  let s:name_poses = []

  while 1
    let s:pos = matchstrpos(a:line, '[a-zA-Z_\-0-9]\+\C', s:start)
    if s:pos[2] < 0
      break
    endif
    call add(s:name_poses, s:pos)
    let s:start = s:pos[2]
  endwhile
  return s:name_poses
endfunction

" adjust __member and __NAME__ naming patterns
" return list ['body', 'prefix', 'sufix']
function! switchname#name#Split(name)
  let s:body = a:name

  let s:prefix_pos = matchstrpos(s:body, '^_\+')
  if s:prefix_pos[1] >= 0
    let s:body = s:body[s:prefix_pos[2]:]
  endif

  let s:sufix_pos = matchstrpos(s:body, '_\+$')
  if s:sufix_pos[1] >= 0
    let s:body = s:body[:s:sufix_pos[1] - 1]
  endif

  return [s:body, s:prefix_pos[0], s:sufix_pos[0]]
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

function! switchname#name#SetRepl(repl, line, pos)
  if a:pos[1] - 1 >= 0
    let s:repl_line = a:line[0:a:pos[1] - 1] . a:repl . a:line[a:pos[2]:]
  else
    echo a:pos
    let s:repl_line = a:repl . a:line[a:pos[2]:]
  endif
  call setline('.', s:repl_line)
endfunction

" ============================================================
" Filename: get.vim
" Author: yuxki
" License: MIT License
" Last Change: 2021/12/15 23:27:32
" ============================================================

let s:save_cpo = &cpo
set cpo&vim

function! switchname#get#GetNamePosIndexOnCursor(name_poses)
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

function! switchname#get#GetNamesInLine(line)
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

let &cpo = s:save_cpo
unlet s:save_cpo

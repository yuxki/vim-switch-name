" ============================================================
" Filename: getname.vim
" Author: yuxki
" License: MIT License
" Last Change: 2021/12/13 11:27:48
" ============================================================

function! switchname#getname#GetNameOnCursor(name_poses)
  let s:curpos_row_inline = getcurpos()[2] - 1
  for name_pos in a:name_poses
    if name_pos[1] <= s:curpos_row_inline && s:curpos_row_inline < name_pos[2]
      return name_pos[0]
    endif
  endfor
  return ""
endfunction

function! switchname#getname#GetNamesInLine(line)
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

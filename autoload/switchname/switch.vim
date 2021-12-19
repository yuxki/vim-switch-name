" ============================================================
" Filename: switch.vim
" Author: yuxki
" License: MIT License
" Last Change: 2021/12/19 00:22:24
" ============================================================
"
function! switchname#switch#SwitchNameOnCursor(convert_func)
  let s:line = getline('.')
  let s:name_poses = switchname#name#GetPosesInLine(s:line)
  let s:index = switchname#name#GetPosIndexOnCursor(s:name_poses)

  if s:index < 0
    return
  endif

  let s:name_parts = switchname#name#SplitFixes(s:name_poses[s:index][0])
  let s:repl = {"switchname#convert#".a:convert_func}(s:name_parts.name)
  call switchname#name#SetRepl(s:repl, s:line, s:name_poses[s:index])
endfunction

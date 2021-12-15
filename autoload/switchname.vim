function! switchname#SwitchName(to_case="UpperCamelCase")
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
  let s:repl_line = s:line[0:s:name_poses[s:index][1] - 1] . s:repl . s:line[s:name_poses[s:index][2]:]
  echo s:repl_line

  " call setline('.', s:repl_line)
endfunction
" __aa__aa__
" __a__

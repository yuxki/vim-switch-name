" ============================================================
" Filename: switchname.vim
" Author: yuxki
" License: MIT License
" Last Change: 2021/12/15 23:27:13
" ============================================================

let s:save_cpo = &cpo
set cpo&vim

" popup filter callback
let s:callback = {}
function s:callback.invoke(key) dict
  call switchname#name#SetRepl(self.repls[a:key], self.line, self.pos)
endfunction

function! switchname#OpenSwitchMenu() abort
  let s:line = getline('.')
  let s:name_poses = switchname#name#GetPosesInLine(s:line)
  let s:index = switchname#name#GetPosIndexOnCursor(s:name_poses)

  if s:index < 0
    return
  endif

  let s:repls = []
  let s:repl_options = []
  let s:splited = switchname#name#Split(s:name_poses[s:index][0])
  let s:itmdt = switchname#convert#MakeIntermidiate(s:splited[0])

  for cs in g:switchname_cases
    "TODO integrate spliting prefix and sufix from name into convert name flow
    let s:repl = s:splited[1] . switchname#convert#ForkName(s:itmdt, cs) . s:splited[2]
    if !switchname#utils#IsStrInList(s:repls, s:repl)
      call add(s:repls, s:repl)
    endif
  endfor

  " set filter callback member
  let s:callback.repls = s:repls
  let s:callback.line = s:line
  let s:callback.pos = s:name_poses[s:index]

  let s:popup_options = #{
  \ title: ' --switch name-- ',
  \ pos: 'botleft',
  \ line: 'cursor-1',
  \ col: 'cursor',
  \ moved: 'any',
  \ highlight: 'Pmenu',
  \ padding: [0, 2, 0, 2],
  \ }

  call switchname#popup#Open(s:repls, s:callback, s:popup_options)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

" ============================================================
" Filename: switchname.vim
" Author: yuxki
" License: MIT License
" Last Change: 2021/12/19 00:26:46
" ============================================================

let s:save_cpo = &cpo
set cpo&vim

" popup filter callback
let s:callback = {}
function! s:callback.invoke(key) dict
  call switchname#name#SetRepl(self.repls[a:key], self.line, self.pos)
endfunction

function! switchname#OpenSwitchMenu(popup_options= #{})
  let s:line = getline('.')
  let s:name_poses = switchname#name#GetPosesInLine(s:line)
  let s:index = switchname#name#GetPosIndexOnCursor(s:name_poses)

  if s:index < 0
    return
  endif

  let s:repls = []
  let s:repl_options = []
  let s:name_parts = switchname#name#SplitFixes(s:name_poses[s:index][0])
  let s:itmdt = switchname#convert#MakeIntermidiate(s:name_parts.name)

  for cs in g:switchname_cases
    let s:repl = s:name_parts.prefix.switchname#convert#Fork(s:itmdt, cs).s:name_parts.sufix
    if !switchname#utils#IsStrInList(s:repls, s:repl)
      call add(s:repls, s:repl)
    endif
  endfor

  " set filter callback members
  let s:callback.repls = s:repls
  let s:callback.line = s:line
  let s:callback.pos = s:name_poses[s:index]

  " ppopup_atcursor() like options
  let s:popup_options = #{
  \ title: ' --switch name-- ',
  \ pos: 'botleft',
  \ line: 'cursor-1',
  \ col: 'cursor',
  \ moved: 'any',
  \ highlight: 'Pmenu',
  \ padding: [0, 2, 0, 2],
  \ }

  for [key, value] in items(a:popup_options)
    let s:popup_options[key] = value
  endfor

  call switchname#popup#Open(s:repls, s:callback, s:popup_options)
endfunction

function! switchname#MapSwitchNameOnCursor(convert_func)
  exec 'nnoremap <silent> <Plug>SwitchNameOnCursor'.a:convert_func.' :call switchname#switch#SwitchNameOnCursor'.'("'.a:convert_func.'")<CR>'
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

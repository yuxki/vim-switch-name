" ============================================================
" Filename: switch.vim
" Author: yuxki
" License: MIT License
" Last Change: 2021/12/15 23:27:13
" ============================================================

let s:save_cpo = &cpo
set cpo&vim

function! switchname#switch#SwitchName(name, to_case)

  " adjust __member and __NAME__ naming patterns
  let s:prefix_pos = matchstrpos(a:name, '^_\+')
  if s:prefix_pos[1] >= 0
    let a:name = a:name[s:prefix_pos[2]:]
  endif

  let s:sufix_pos = matchstrpos(a:name, '_\+$')
  if s:sufix_pos[1] >= 0
    let a:name = a:name[:s:sufix_pos[1] - 1]
  endif

  let s:repl = s:prefix_pos[0] . switchname#convert#ConvertName(a:name, a:to_case) . s:sufix_pos[0]
  return s:repl
endfunction

function! switchname#switch#ForkName(itmdt, to_case)
    if a:to_case == 'UpperCamelCase'
      return switchname#convert#ForkToUpperCamel(a:itmdt)
    elseif a:to_case == 'lowerCamelCase'
      return switchname#convert#ForkToLowerCamel(a:itmdt)
    elseif a:to_case == 'UPPER_SNAKE_CASE'
      return switchname#convert#ForkToUpperSnake(a:itmdt)
    elseif a:to_case == 'lower_snake_case'
      return switchname#convert#ForkToLowerSnake(a:itmdt)
    elseif a:to_case == 'UPPER-KEBAB-CASE'
      return switchname#convert#ForkToUpperKebab(a:itmdt)
    elseif a:to_case == 'lower-kebab-case'
      return switchname#convert#ForkToLowerKebab(a:itmdt)
    endif
    return ''
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

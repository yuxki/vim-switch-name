" ============================================================
" Filename: convert.vim
" Author: yuxki
" License: MIT License
" Last Change: 2021/12/15 23:27:13
" ============================================================

let s:save_cpo = &cpo
set cpo&vim

function! switchname#convert#ConvertName(name, to_case)
  " convert name into intermediate format to convert several cases
  let s:intermidiate_name = substitute(a:name ,'[-_]\+', '_', 'g')
  if a:name =~# '\l' && a:name =~# '\u'
    let s:intermidiate_name = substitute(s:intermidiate_name, '\(\u\)',  '_\1', 'g')
  endif
  let s:intermidiate_name = substitute(s:intermidiate_name, '^_', '', '')

  let s:name = s:intermidiate_name

  if a:to_case == "UpperCamelCase" || a:to_case == "lowerCamelCase"
    let s:name = substitute(s:name, '\([a-zA-Z]\)\([a-zA-Z]*\)\C', '\=toupper(submatch(1)).tolower(submatch(2))', 'g')
    if a:to_case == "lowerCamelCase"
      let s:name = substitute(s:name, '\(\u\)', '\=tolower(submatch(1))', '')
    endif
    return substitute(s:name, '_', '', 'g')
  endif

  if a:to_case == "lower_snake_case" || a:to_case == "UPPER_SNAKE_CASE"
    if a:to_case == "lower_snake_case"
      let s:name = tolower(s:name)
    else
      let s:name = toupper(s:name)
    endif
    return s:name
  endif

  if a:to_case == "lower-kebab-case" || a:to_case == "UPPER-KEBAB-CASE"
    let s:name = substitute(s:name, '_', '-', 'g')
    if a:to_case == "lower-kebab-case"
      let s:name = tolower(s:name)
    else
      let s:name = toupper(s:name)
    endif
    return s:name
  endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

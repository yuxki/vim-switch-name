" ============================================================
" Filename: utils.vim
" Author: yuxki
" License: MIT License
" Last Change: 2021/12/19 00:28:15
" ============================================================

function! switchname#utils#IsStrInList(list, str)
  for elem in a:list
    if match(elem, a:str.'\C') >= 0
      return 1
    endif
  endfor
  return 0
endfunction

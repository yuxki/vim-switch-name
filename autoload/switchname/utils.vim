" ============================================================
" Filename: utils.vim
" Author: yuxki
" License: MIT License
" Last Change: 2021/12/17 00:53:24
" ============================================================

function! switchname#utils#IsStrInList(list, str)
  for elem in a:list
    if match(elem, a:str.'\C') >= 0
      return 1
    endif
  endfor
  return 0
endfunction

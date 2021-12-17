" ============================================================
" Filename: convert.vim
" Author: yuxki
" License: MIT License
" Last Change: 2021/12/15 23:27:13
" ============================================================

let s:save_cpo = &cpo
set cpo&vim

function! switchname#convert#MakeIntermidiate(name)
  let s:itmdt_name = substitute(a:name ,'[-_]\+', '_', 'g')
  if a:name =~# '\l' && a:name =~# '\u'
    let s:itmdt_name = substitute(s:itmdt_name, '\(\u\)',  '_\1', 'g')
  endif
  let s:itmdt_name = substitute(s:itmdt_name, '^_', '', '')
  return s:itmdt_name
endfunction

function! switchname#convert#ForkToUpperCamel(itmdt)
  return substitute(
          \substitute(a:itmdt, '\([a-zA-Z]\)\([a-zA-Z]*\)\C', '\=toupper(submatch(1)).tolower(submatch(2))', 'g')
          \, '_', '', 'g')
endfunction

function! switchname#convert#ForkToLowerCamel(itmdt)
  return substitute(
          \ switchname#convert#ForkToUpperCamel(a:itmdt),
          \  '\(\u\)', '\=tolower(submatch(1))', '')
endfunction

function! switchname#convert#ForkToUpperSnake(itmdt)
  return toupper(a:itmdt)
endfunction

function! switchname#convert#ForkToLowerSnake(itmdt)
  return toupper(a:itmdt)
endfunction

function! switchname#convert#ForkToUpperKebab(itmdt)
  return toupper(substitute(a:itmdt, '_', '-', 'g'))
endfunction

function! switchname#convert#ForkToLowerKebab(itmdt)
  return tolower(substitute(a:itmdt, '_', '-', 'g'))
endfunction

function! switchname#convert#ConvertToUpperCamel(name)
  return switchname#convert#ForkToUpperCamel(switchname#convert#MakeIntermidiate(a:name))
endfunction

function! switchname#convert#ConvertToLowerCamel(name)
  return switchname#convert#ForkToLowerCamel(switchname#convert#MakeIntermidiate(a:name))
endfunction

function! switchname#convert#ConvertToUpperSnake(name)
  return switchname#convert#ForkToUpperSnake(switchname#convert#MakeIntermidiate(a:name))
endfunction

function! switchname#convert#ConvertToLowerSnake(name)
  return switchname#convert#ForkToLowerSnake(switchname#convert#MakeIntermidiate(a:name))
endfunction

function! switchname#convert#ConvertToUpperKebab(name)
  return switchname#convert#ForkToUpperKebab(switchname#convert#MakeIntermidiate(a:name))
endfunction

function! switchname#convert#ConvertToLowerKebab(name)
  return switchname#convert#ForkToLowerKebab(switchname#convert#MakeIntermidiate(a:name))
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

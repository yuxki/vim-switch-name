" ============================================================
" Filename: popup.vim
" Author: yuxki
" License: MIT License
" Last Change: 2021/12/17 10:58:07
" ============================================================

let s:popup_filter = {}
function! s:popup_filter.invoke(winid, key) dict
  if a:key =~# '\a' || a:key =~# ':'
    call popup_close(a:winid)
  elseif len(a:key) == 1 && a:key =~# '\d' && a:key >= 0 && a:key < self.max_index
    call self.callback.invoke(a:key)
    call popup_close(a:winid)
  endif
  return 1
endfunction

function! s:CallPopupFilter(winid, key)
  return s:popup_filter.invoke(a:winid, a:key)
endfunction

function! s:GetScriptNumber()
  return matchstr(expand('<SID>'), '<SNR>\zs\d\+\ze_')
endfunction

" TODO popup option nubmer over 10
function! switchname#popup#Open(what, callback, options)
  if len(a:what) <= 0
    return
  endif

  let s:options = #{ close: 'button', filter: '<SNR>'.s:GetScriptNumber().'_CallPopupFilter' }
  for [key, value] in items(a:options)
    let s:options[key] = value
  endfor

  let s:what = []
  let s:key_number = 0
  for w in a:what
    call add(s:what, string(s:key_number) . ': '. w)
    let s:key_number += 1
  endfor

  let s:popup_filter.max_index = s:key_number
  let s:popup_filter.callback = a:callback

  return popup_create(s:what, s:options)
endfunction

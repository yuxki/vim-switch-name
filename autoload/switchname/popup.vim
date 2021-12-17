" ============================================================
" Filename: popup.vim
" Author: yuxki
" License: MIT License
" Last Change: 2021/12/17 10:58:07
" ============================================================

function! s:GetScriptNumber()
  return matchstr(expand('<SID>'), '<SNR>\zs\d\+\ze_')
endfunction

" TODO popup option nubmer over 10
function! switchname#popup#Open(what, callback, max_index, options)

  let s:__filter = {}
  function! s:__filter.invoke(winid, key) dict
    if a:key =~# '\a' || a:key =~# ':'
      call popup_close(a:winid)
    elseif a:key =~# '\d' && a:key >= 0 && a:key < self.max_index
      call self.callback.invoke(a:key)
      call popup_close(a:winid)
    endif
    return 1
  endfunction

  let s:__filter.callback = a:callback
  let s:__filter.max_index = a:max_index

  function! s:PopupQuickPickerFilter(winid, key)
    return s:__filter.invoke(a:winid, a:key)
  endfunction

  let s:filter_name = '<SNR>'.s:GetScriptNumber().'_PopupQuickPickerFilter'
  let s:options = #{ close: 'button', filter: s:filter_name }
  for [key, value] in items(a:options)
    let s:options[key] = value
  endfor

  return popup_atcursor(a:what, s:options)
endfunction

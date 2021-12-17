if exists('g:loaded_switchname')
  finish
endif
let g:loaded_switch_name = 1

let s:save_cpo = &cpo
set cpo&vim

if !exists('g:switchname_popup_upper_camel')
  let g:switchname_popup_upper_camel = 1
endif
if !exists('g:switchname_popup_lower_camel')
  let g:switchname_popup_lower_camel = 1
endif
if !exists('g:switchname_popup_upper_snake')
  let g:switchname_popup_upper_snake = 1
endif
if !exists('g:switchname_popup_lower_snake')
  let g:switchname_popup_lower_snake = 1
endif
if !exists('g:switchname_popup_upper_kebab')
  let g:switchname_popup_upper_kebab = 1
endif
if !exists('g:switchname_popup_lower_kebab')
  let g:switchname_popup_lower_kebab = 1
endif

let g:switchname_cases = []
if g:switchname_popup_upper_camel == 1
  call add(g:switchname_cases, 'UpperCamelCase')
endif
if g:switchname_popup_lower_camel == 1
  call add(g:switchname_cases, 'lowerCamelCase')
endif
if g:switchname_popup_upper_snake == 1
  call add(g:switchname_cases, 'UPPER_SNAKE_CASE')
endif
if g:switchname_popup_lower_snake == 1
  call add(g:switchname_cases, 'lower_snake_case')
endif
if g:switchname_popup_upper_kebab == 1
  call add(g:switchname_cases, 'UPPER-KEBAB-CASE')
endif
if g:switchname_popup_lower_kebab == 1
  call add(g:switchname_cases, 'lower-kebab-case')
endif

command! Switchname :call switchname#OpenSwitchMenu()
noremap <silent> <F2> :call switchname#OpenSwitchMenu()<CR>

let &cpo = s:save_cpo
unlet s:save_cpo

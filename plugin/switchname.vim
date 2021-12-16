if exists('g:loaded_switchname')
  finish
endif
let g:loaded_switch_name = 1

let s:save_cpo = &cpo
set cpo&vim

command! Switchname :call switchname#OpenSwitchMenu()
nnoremap <F2> :Switchname<CR>

let &cpo = s:save_cpo
unlet s:save_cpo

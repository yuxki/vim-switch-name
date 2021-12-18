let s:save_cpo = &cpo
set cpo&vim

function! switchname#test#run()
  " init errors
  let v:errors = []

  " start tests
  try
    call switchname#test#test_convert#run()
  catch
    execute "cq!"
  endtry

  if len(v:errors) > 0
    for error in v:errors
      "execute "silent !echo E"
      let s:msg =  escape(error, "#")
      execute "silent !echo " . s:msg
    endfor
    execute "cq!"
  endif

  " end test
  execute "silent !echo \"OK\""
  execute "qall!"
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

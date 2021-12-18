let s:save_cpo = &cpo
set cpo&vim

function! switchname#test#test_convert#test_convert(inputs, expectation, target)
  for input in a:inputs
    let s:result = ""
    if a:target == "UpperCamelCase"
      let s:result = switchname#convert#ToUpperCamel(input)
    elseif a:target == "lowerCamelCase"
      let s:result = switchname#convert#ToLowerCamel(input)
    elseif a:target == "lower_snake_case"
      let s:result = switchname#convert#ToLowerSnake(input)
    elseif a:target == "UPPER_SNAKE_CASE"
      let s:result = switchname#convert#ToUpperSnake(input)
    elseif a:target == "lower-kebab-case"
      let s:result = switchname#convert#ToLowerKebab(input)
    elseif a:target == "UPPER-KEBAB-CASE"
      let s:result = switchname#convert#ToUpperKebab(input)
    endif
    call assert_equal(a:expectation, s:result, "faild translate ". input . " with " . a:target)
  endfor
endfunction

" TODO add test routine
function! switchname#test#test_convert#run()
let v:errors = []

let s:inputs = ["aa-bb-cc", "AA-BB-CC", "aa_bb_cc", "AA_BB_CC", "aaBbCc" , "AaBbCc", "aa-bb__cc"]

"===========Test UpperCamelCase===========
let s:expectation = 'AaBbCc'
call switchname#test#test_convert(s:inputs, s:expectation, "UpperCamelCase")

"===========Test lowerCamelCase===========
let s:expectation = 'aaBbCc'
call switchname#test#test_convert(s:inputs, s:expectation, "lowerCamelCase")

"===========Test lower_snake_case===========
let s:expectation = 'aa_bb_cc'
call switchname#test#test_convert(s:inputs, s:expectation, "lower_snake_case")

"===========Test UPPER_SNAKE_CASE===========
let s:expectation = 'AA_BB_CC'
call switchname#test#test_convert(s:inputs, s:expectation, "UPPER_SNAKE_CASE")

"===========Test lower_snake_case===========
let s:expectation = 'aa-bb-cc'
call switchname#test#test_convert(s:inputs, s:expectation, "lower-kebab-case")

"===========Test UPPER_SNAKE_CASE===========
let s:expectation = 'AA-BB-CC'
call switchname#test#test_convert(s:inputs, s:expectation, "UPPER-KEBAB-CASE")

if len(v:errors) > 0
  for err in v:errors
    echo err
  endfor
else
  echo "OK"
endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

" CaseComplete

" Converts the case of the selected text from case `query_*` to case `new_*`.
" @param from*:      The case of the text to search for.
" @param to:         The case to convert text into.
" @param no_prompt:  If (!= ""), then the user will not be prompted for
"                    changes.
" @param start_ln: The first line to convert.
" @param end_ln:   The last line to convert.
function! Conv(start_ln, end_ln, no_prompt, from, to)

  " Parse noPrompt arg
  if a:noPrompt
    let modifiers= "ge"
  else
    let modifiers= "gec"
  endif

  " A giant if statement. TODO clean up by splitting up parsing into two
  " sections.
  " Upper followed by >=0 lowerchars ++ delim ++ Upper
  if a:from == "XX"
    query = '\(\u\l*\)\(\u\)'
  elseif a:from == "XX_"
    query = '\(\u\l*\)\@<=_\(\u\)'
  elseif a:from == "XX-"
    query = '\(\u\l*\)\@<=-\(\u\)'

  elseif a:from == "xX"
    query = '\(\<\l\+\|\l*\)\(\u\)'
  elseif a:from == "xX_"
    query = '\(\<\l\+\|\l*\)@<=_\(\u\)'
  elseif a:from == "xX-"
    query = '\(\<\l\+\|\l*\)@<=-\(\u\)'

  elseif a:from == "Xx"
    query = '\(\<\u\l*\|\l*\)\(\l\)'
  elseif a:from == "Xx_"
    query = '\(\<\u\l*\|\l*\)@<=_\(\l\)'
  elseif a:from == "Xx-"
    query = '\(\<\u\l*\|\l*\)@<=-\(\l\)'

  elseif a:from == "X"
    query = '\(\<\u\+)\(\u\)'
  elseif a:from == "X_"
    query = '\(\<\u\+)@<=_\(\u\)'
  elseif a:from == "X-"
    query = '\(\<\u\+)@<=-\(\u\)'

  elseif a:from == "x" || a:from == "xx"
    query = '\(\<\l\+)\(\l\)'
  elseif a:from == "x_" || a:from == "xx_"
    query = '\(\<\l\+)@<=_\(\l\)'
  elseif a:from == "x-" || a:from == "xx-"
    query = '\(\<\l\+)@<=-\(\l\)'
  endif

  " Another giant if. TODO: Split this up into cases.
  " Upper followed by >=0 lowerchars ++ delim ++ Upper
  if a:to == "XX"
    replace = '\u\1\u\2'
  elseif a:to == "XX_"
    replace =  '\u\1\@<=_\u\2'
  elseif a:to == "XX-"
    replace =  '\u\1\@<=-\u\2'

  elseif a:to == "xX"
    replace = '\l\1\u\2'
  elseif a:to == "xX_"
    replace =  '\l\1\@<=_\u\2'
  elseif a:to == "xX-"
    replace =  '\l\1\@<=-\u\2'

  elseif a:to == "Xx"
    replace = '\u\1\l\2'
  elseif a:to == "Xx_"
    replace =  '\u\1\@<=_\l\2'
  elseif a:to == "Xx-"
    replace =  '\u\1\@<=-\l\2'

  elseif a:to == "X"
    replace = '\U\1\U\2'
  elseif a:to == "X_"
    replace =  '\U\1\@<=_\U\2'
  elseif a:to == "X-"
    replace =  '\U\1\@<=-\U\2'

  elseif a:to == "x" || a:to == "xx"
    replace =  '\l\1\l\2'
  elseif a:to == "x_" || a:to == "xx_"
    replace =  '\l\1\l\2'
  elseif a:to == "x-" || a:to == "xx-"
    replace =  '\l\1\l\2'
  endif

  " Execute the command
  exe a:start_ln . "," . a:end_ln . "s#" . selection_mod . query . "#" . replace . "#" . modifiers

endfunction

" Available commands
command! -nargs=+ -range=% -bang Conv call Conv(<line1>,<line2>,<bang>,<f-args>)

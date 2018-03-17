" CaseComplete
" Converts the case of the selected text from case `replace_*` to case `new_*`.
" @param from*:      The case of the text to search for.
" @param to:         The case to convert text into.
" @param no_prompt:  If (!= ""), then the user will not be prompted for
"                    changes.
" @param line1: The first line to convert.
" @param line2:   The last line to convert.
function! Case(line1, line2, no_prompt, from, to)

  " Parse no_prompt arg
  if a:no_prompt
    let modifiers = "ge"
  else
    let modifiers = "gec"
  endif


  " A giant if statement. TODO clean up by splitting up parsing into two
  " sections.
  " Upper followed by >=0 lowerchars ++ delim ++ Upper
  if a:from == "XX"
    let query = '\v(<\u)(\l*)_(\u)(.*)'
  elseif a:from == "XX_"
    let query = '\v(<\u)((\l|_)*)_(\u)(.*)'
  elseif a:from == "XX-"
    let query = '\v(<\u)((\l|-)*)-(\u)(.*)'

  elseif a:from == "xX"
    let query = '\v(<\l)\l*)_(\u)(.*)'
  elseif a:from == "xX_"
    let query = '\v(<\l)((\l|_)*)_(\u)(.*)'
  elseif a:from == "xX-"
    let query = '\v(<\l)((\l|-)*)-(\u)(.*)'

  elseif a:from == "Xx"
    let query = '\v(<\u)(\l*)_(\l)(.*)'
  elseif a:from == "Xx_"
    let query = '\v(<\u)((\l|_)*)_(\l)(.*)'
  elseif a:from == "Xx-"
    let query = '\v(<\u)((\l|-)*)-(\l)(.*)'

  " We cannot bijectively map "X" as we don't know where word boundaries are.
  elseif a:from == "X_"
    let query = '\v(<\u)((\u|_)*)_(\u)(.*)'
  elseif a:from == "X-"
    let query = '\v(<\u)((\u|-)*)-(\u)(.*)'

  " We cannot bijectively map "x" as we don't know where word boundaries are.
  elseif a:from == "x_" || a:from == "xx_"
    let query = '\v(<\l)((\l|_)*)_(\l)(.*)'
  elseif a:from == "x-" || a:from == "xx-"
    let query = '\v(<\l)((\l|-)*)-(\l)(.*)'
  endif

  " Another giant if. TODO: Split this up into cases.
  " Upper followed by >=0 lowerchars ++ delim ++ Upper
  if a:to == "XX"
    let replace = '\u\1\2\u\3\4'
  elseif a:to == "XX_"
    let replace = '\u\1\2_\u\3\4'
  elseif a:to == "XX-"
    let replace = '\u\1\2-\u\3\4'

  elseif a:to == "xX"
    let replace = '\u\2'
  elseif a:to == "xX_"
    let replace = '_\u\2'
  elseif a:to == "xX-"
    let replace = '\l\1\-\u\2'

  elseif a:to == "Xx"
    let replace = '\u\1\l\2'
  elseif a:to == "Xx_"
    let replace = '\u\1\_\l\2'
  elseif a:to == "Xx-"
    let replace = '\u\1\-\l\2'

  elseif a:to == "X"
    let replace = '\U\1\U\2'
  elseif a:to == "X_"
    let replace = '\U\1\_\U\2'
  elseif a:to == "X-"
    let replace = '\U\1\-\U\2'

  elseif a:to == "x" || a:to == "xx"
    let replace = '\l\1\l\2'
  elseif a:to == "x_" || a:to == "xx_"
    let replace = '\l\1_\l\2'
  elseif a:to == "x-" || a:to == "xx-"
    let replace = '\l\1-\l\2'
  endif

  " Execute the command
  :execute "'<,'>" . "s/" . query . "/" . replace . "/g"

endfunction

" Available commands
command! -nargs=+ -range=% -bang Case call Case(<line1>,<line2>,<bang>0,<f-args>)

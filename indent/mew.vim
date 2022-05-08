" Copyright (c) 2022 Dani Ryśki
"
" Vim indent file
" Language: Mew

" quit when an indent file has already been loaded
if exists("b:did_indent")
  finish
endif

setlocal indentexpr=MewIndent()
setlocal indentkeys+=0=let,0=if,0=then,0=else
setlocal nolisp
setlocal nosmartindent

" quit when MewIndent has already been defined
if exists("*MewIndent")
  finish
endif

function! MewIndent()
  let l:lnum = v:lnum - 1
  if l:lnum == 0
    return 0
  endif

  let l:line = getline(l:lnum)
  let l:next_line = getline(v:lnum)
  let l:indent = indent(l:lnum)

  " indent lines after a let definition
  if l:line =~# '\<let\>.*=$'
    return l:indent + 4 + shiftwidth()

  " match the indentation 'then', and 'else' with a previous 'if'
  elseif l:next_line =~# '^\s*\<then\>' || l:next_line =~# '^\s*\<else\>'
    return indent(search('\<if\>', 'bW'))

  " indent after 'if', 'then', and 'else'
  elseif l:line =~# '^\s*\<if\>$' || l:line =~# '^\s*\<then\>$' || l:line =~# '^\s*\<else\>$'
    return l:indent + shiftwidth()

  " deindent after empty lines
  elseif l:line =~ '^\s*$'
    let l:n = 0
    " search for, and return the indentation of the parent 'let'
    while getline(l:lnum - l:n) =~ '^\s*$'
      let l:let_line = search('\<let\>', 'bW')
      if indent(l:let_line) < indent(prevnonblank(l:lnum))
        let l:n = l:n + 1
      endif

      cursor(l:let_line, 1)
    endwhile

    return indent(getcurpos()[1])

  " default: return the previous indentation
  else
    return l:indent

  endif
endfunction

let b:did_indent = 1

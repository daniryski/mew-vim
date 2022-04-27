" Copyright (c) 2022 Dani Ryśki
"
" Vim syntax file
" Language: Mew

" quit when a syntax file has already been loaded
if exists("b:current_syntax")
  finish
endif

" binary infix operators
syn match mewOperator "=\|<\|>\|==\|<=\|>=\|+\|-\|*\|/" contained
syn match mewParens "(\|)" contained

" int
syn match mewInt "\<\d\+\>" contained

" if then else
syn keyword mewConditional if then else contained

" let
syn keyword mewLet let contained

syn region mewLine start="^" end="$" contains=mewOperator,mewParens,mewInt,mewConditional,mewLet

" Highlighting
hi def link mewOperator Operator
hi def link mewParens Operator
hi def link mewInt Number
hi def link mewConditional Conditional
hi def link mewLet Keyword

let b:current_syntax = "mew"

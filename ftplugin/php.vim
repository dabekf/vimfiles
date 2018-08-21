if exists("b:did_myftplugin") | finish | endif
let b:did_myftplugin = 1

call myconf#func#Markers('function \?[a-zA-Z0-9_ ]*(.*)\(:[a-zA-Z0-9_]\+\)\?\s*\n\s*{')
" call myconf#func#Markers2(function('ft#php#Fold'), 0)

if match(expand('%:p'), '\v\\nt-.{-}\\') != -1
    map <buffer> <Leader>p :call ft#php#Phpcbf()<CR>
else
    " map <Leader>p :call ft#php#Phpcbf()<CR>
    map <buffer> <Leader>p :call ft#php#FixParens()<CR>
    map <buffer> <Leader>P :call ft#php#FixParensPsr2()<CR>
endif

let tlist_php_settings = 'php;f:function'

let g:tcomment#filetype#guess_php = 'php'
xmap <buffer> <A-C> <C-_>aphp_2_block<CR>

" setlocal colorcolumn=120

let b:match_words='<?php:?>,\<switch\>:\<endswitch\>,\<if\>:\<elseif\>:\<else\>,\<while\>:\<endwhile\>,\<do\>:\<while\>,\<for\>:\<endfor\>,\<foreach\>:\<endforeach\>,(:),[:],{:},<:>,<\@<=[ou]l\>[^>]*\%(>\|$\):<\@<=li\>:<\@<=/[ou]l>,<\@<=dl\>[^>]*\%(>\|$\):<\@<=d[td]\>:<\@<=/dl>,<\@<=\([^/][^ \t>]*\)\%(>\|$\|[ \t][^>]*\%(>\|$\)\):<\@<=/\1>'


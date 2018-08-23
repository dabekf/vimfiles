" Underscore and camelcase
function! UnderscoreToCamelCase(s)
    let result = substitute(a:s, '\C\S\@<=_\([a-z]\)', '\u\1', 'ge')
    if (exists("b:underscore_to_camel_case_first_upper") && b:underscore_to_camel_case_first_upper == 1)
        return substitute(result, '\([a-z]\)', '\u\1', 'e')
    else
        return result
    endif
endf

function! CamelCaseToUnderscore(s)
    let result = substitute(a:s, '\C\<\@!\([A-Z]\)', '\_\l\1', 'ge')
    return substitute(result, '\([A-Z]\)', '\l\1', 'e')
endf

xnoremap <silent> <A-+> "-d:let @- = UnderscoreToCamelCase(@-)<CR>"-P
xnoremap <silent> <A-_> "-d:let @- = CamelCaseToUnderscore(@-)<CR>"-P
nnoremap <silent> <A-+> :call myconf#func#RunInPlace(['Nviw"-d', 'Rlet @- = UnderscoreToCamelCase(@-)', 'N"-P'])<CR>
nnoremap <silent> <A-_> :call myconf#func#RunInPlace(['Nviw"-d', 'Rlet @- = CamelCaseToUnderscore(@-)', 'N"-P'])<CR>
inoremap <silent> <A-+> <C-o>:call myconf#func#RunInPlace(['Nviw"-d', 'Rlet @- = UnderscoreToCamelCase(@-)', 'N"-P'])<CR>
inoremap <silent> <A-_> <C-o>:call myconf#func#RunInPlace(['Nviw"-d', 'Rlet @- = CamelCaseToUnderscore(@-)', 'N"-P'])<CR>

xnoremap <silent> <A-=> gU
xnoremap <silent> <A--> gu
nnoremap <silent> <A-=> :call myconf#func#RunInPlace(['NviwgU'])<CR>
nnoremap <silent> <A--> :call myconf#func#RunInPlace(['Nviwgu'])<CR>
inoremap <silent> <A-=> <C-o>:call myconf#func#RunInPlace(['NviwgU'])<CR>
inoremap <silent> <A--> <C-o>:call myconf#func#RunInPlace(['Nviwgu'])<CR>


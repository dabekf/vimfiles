" Underscore and camelcase
xnoremap <silent> <A-+> "-d:let @- = UnderscoreToCamelCase(@-)<CR>"-P
xnoremap <silent> <A-_> "-d:let @- = CamelCaseToUnderscore(@-)<CR>"-P
nnoremap <silent> <A-+> :call myconf#misc#RunInPlace(['Nviw"-d', 'Rlet @- = myconf#edit#UnderscoreToCamelCase(@-)', 'N"-P'])<CR>
nnoremap <silent> <A-_> :call myconf#misc#RunInPlace(['Nviw"-d', 'Rlet @- = myconf#edit#CamelCaseToUnderscore(@-)', 'N"-P'])<CR>
inoremap <silent> <A-+> <C-o>:call myconf#misc#RunInPlace(['Nviw"-d', 'Rlet @- = myconf#edit#UnderscoreToCamelCase(@-)', 'N"-P'])<CR>
inoremap <silent> <A-_> <C-o>:call myconf#misc#RunInPlace(['Nviw"-d', 'Rlet @- = myconf#edit#CamelCaseToUnderscore(@-)', 'N"-P'])<CR>

xnoremap <silent> <A-=> gU
xnoremap <silent> <A--> gu
nnoremap <silent> <A-=> :call myconf#misc#RunInPlace(['NviwgU'])<CR>
nnoremap <silent> <A--> :call myconf#misc#RunInPlace(['Nviwgu'])<CR>
inoremap <silent> <A-=> <C-o>:call myconf#misc#RunInPlace(['NviwgU'])<CR>
inoremap <silent> <A--> <C-o>:call myconf#misc#RunInPlace(['Nviwgu'])<CR>


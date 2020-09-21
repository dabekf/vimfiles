" Underscore and camelcase
xnoremap <silent> <Esc>+ "-d:let @- = UnderscoreToCamelCase(@-)<CR>"-P
xnoremap <silent> <Esc>_ "-d:let @- = CamelCaseToUnderscore(@-)<CR>"-P
nnoremap <silent> <Esc>+ :call myconf#misc#RunInPlace(['Nviw"-d', 'Rlet @- = myconf#edit#UnderscoreToCamelCase(@-)', 'N"-P'])<CR>
nnoremap <silent> <Esc>_ :call myconf#misc#RunInPlace(['Nviw"-d', 'Rlet @- = myconf#edit#CamelCaseToUnderscore(@-)', 'N"-P'])<CR>
inoremap <silent> <Esc>+ <C-o>:call myconf#misc#RunInPlace(['Nviw"-d', 'Rlet @- = myconf#edit#UnderscoreToCamelCase(@-)', 'N"-P'])<CR>
inoremap <silent> <Esc>_ <C-o>:call myconf#misc#RunInPlace(['Nviw"-d', 'Rlet @- = myconf#edit#CamelCaseToUnderscore(@-)', 'N"-P'])<CR>

xnoremap <silent> <Esc>= gU
xnoremap <silent> <Esc>- gu
nnoremap <silent> <Esc>= :call myconf#misc#RunInPlace(['NviwgU'])<CR>
nnoremap <silent> <Esc>- :call myconf#misc#RunInPlace(['Nviwgu'])<CR>
inoremap <silent> <Esc>= <C-o>:call myconf#misc#RunInPlace(['NviwgU'])<CR>
inoremap <silent> <Esc>- <C-o>:call myconf#misc#RunInPlace(['Nviwgu'])<CR>

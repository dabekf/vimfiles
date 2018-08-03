" Underscore and camelcase
function! UnderscoreToCamelCase(s)
	let result = substitute(a:s, '\C\S\@<=_\([a-z]\)', '\u\1', 'ge')
	if (exists("b:underscoreToCamelCaseFirstUpper") && b:underscoreToCamelCaseFirstUpper == 1)
		return substitute(result, '\([a-z]\)', '\u\1', 'e')
	else
		return result
	endif
endf

function! CamelCaseToUnderscore(s)
	let result = substitute(a:s, '\C\<\@!\([A-Z]\)', '\_\l\1', 'ge')
	return substitute(result, '\([A-Z]\)', '\l\1', 'e')
endf

xnoremap <silent> <A-+> mZ"-d:let @- = UnderscoreToCamelCase(@-)<CR>"-Pg`Z
xnoremap <silent> <A-_> mZ"-d:let @- = CamelCaseToUnderscore(@-)<CR>"-Pg`Z
nnoremap <silent> <A-+> mZviw"-d:let @- = UnderscoreToCamelCase(@-)<CR>"-Pg`Z
nnoremap <silent> <A-_> mZviw"-d:let @- = CamelCaseToUnderscore(@-)<CR>"-Pg`Z
inoremap <silent> <A-+> <C-o>mZ<C-o>viw"-d<C-o>:let @- = UnderscoreToCamelCase(@-)<CR><C-o>"-P<C-o>g`Z
inoremap <silent> <A-_> <C-o>mZ<C-o>viw"-d<C-o>:let @- = CamelCaseToUnderscore(@-)<CR><C-o>"-P<C-o>g`Z

xnoremap <silent> <A-=> mZgUg`Z
xnoremap <silent> <A--> mZgug`Z
nnoremap <silent> <A-=> mZviwgUg`Z
nnoremap <silent> <A--> mZviwgug`Z
inoremap <silent> <A-=> <C-o>mZ<C-o>viwgU<C-o>g`Z
inoremap <silent> <A--> <C-o>mZ<C-o>viwgu<C-o>g`Z


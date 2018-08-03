let g:smartBackspacePattern = join(['\V\s\@<=\.', '\_^\@<=\.', '\[\^;[=,({<>''`"./_$@!:#]\@<=\.', '\(->\)\@<=\.', '-\@<=\[^>]', '\(::\)\@<=\.', '\u\@<!\u'], '\|')
function! SmartBackspace()
	return search(g:smartBackspacePattern, 'b')
endf

" M-<BS> is delete what I want
inoremap <silent> <A-BS> <C-o>"_d:call SmartBackspace()<CR>
cnoremap <silent> <A-BS> <C-w>

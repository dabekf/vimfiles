let g:myconf_markers_pattern = 'function \?[a-zA-Z0-9_ ]*(.*)\(:[a-zA-Z0-9_]\+\)\?\s*\n\s*{'
call myconf#func#Markers()
"exe "NoMatchParen"

" map ,l :echo system('php -l ' . shellescape(expand("%:p")) . ' \| grep -v "No syntax errors detected"')<CR>

if match(expand('%:p'), '\v\\nt-.{-}\\') != -1
	map ,p :call ft#php#Phpcbf()<CR>
else
	" map ,p :call ft#php#Phpcbf()<CR>
	map ,p :call ft#php#FixParens()<CR>
	map ,P :call ft#php#FixParensPsr2()<CR>
endif

let tlist_php_settings = 'php;f:function'

let g:tcomment#filetype#guess_php = 'php'
xmap <A-C> <C-_>aphp_2_block<CR>

" setlocal colorcolumn=120


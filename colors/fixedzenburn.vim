runtime colors/zenburn.vim

" MyZenburn
hi WarningMsg guifg=#efef87
hi Cursor guifg=#000d18 guibg=#efefef

function! s:DisableFontStyles()
	let his = ''
	redir => his
	silent hi
	redir END
	let his = substitute(his, '\n\s\+', ' ', 'g')
	for line in split(his, "\n")
		if line !~ ' links to ' && line !~ ' cleared$'
			exe 'hi' substitute(substitute(line, ' xxx ', ' ', ''), '\(italic\|bold\)', 'none', 'g')
		endif
	endfor
endfunction
call s:DisableFontStyles()

" StatusLine

" Paste
hi User1 guifg=#ffffff guibg=#313633

" Modes
hi User2 guifg=#000000 guibg=#ccdc90
hi User3 guifg=white guibg=firebrick3
hi User4 guifg=yellow guibg=forestgreen
hi User5 guifg=yellow guibg=darkorchid

" Errors
hi User6 guifg=#efef87 guibg=#313633
hi User7 guifg=#e37170 guibg=#313633
" hi User7 guifg=#cc9393 guibg=#313633

" Buffers
hi User8 guifg=#ffffff guibg=#313633 gui=underline

let g:colors_name="fixedzenburn"

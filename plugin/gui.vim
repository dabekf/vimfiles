let g:zenburn_high_Contrast = 1
let g:zenburn_old_Visual = 1
let g:zenburn_alternate_Visual = 1
let g:zenburn_unified_CursorColumn = 1

try
	colorscheme zenburn
catch
	colorscheme darkblue
endtry

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

" set guifont=Consolas:h12
set guifont=Fixed_9x15:h11
set guioptions=egcA


runtime colors/zenburn.vim

if !exists('g:colors_name') || g:colors_name != 'zenburn'
	runtime colors/darkblue.vim
endif

" MyZenburn
hi WarningMsg guifg=#efef87
hi Cursor guifg=#000d18 guibg=#efefef
hi NonText guifg=#5b605e

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
hi MyconfStlModeNormalStr guifg=#000000 guibg=#ccdc90
hi MyconfStlModeNormalRev guifg=#313633 guibg=#ccdc90 gui=reverse
hi MyconfStlModeVisualStr guifg=white guibg=firebrick3
hi MyconfStlModeVisualRev guifg=#313633 guibg=firebrick3 gui=reverse
hi MyconfStlModeInsertStr guifg=yellow guibg=forestgreen
hi MyconfStlModeInsertRev guifg=#313633 guibg=forestgreen gui=reverse
hi MyconfStlModeReplaceStr guifg=yellow guibg=#22698C
hi MyconfStlModeReplaceRev guifg=#313633 guibg=#22698C gui=reverse
hi MyconfStlModeDefaultStr guifg=yellow guibg=darkorchid
hi MyconfStlModeDefaultRev guifg=#313633 guibg=darkorchid gui=reverse
hi MyconfStlActiveBuffer guifg=#ffffff guibg=#313633 gui=underline
hi MyconfStlRunning guifg=#efef87 guibg=#313633
hi MyconfStlError guifg=#e37170 guibg=#313633

" BetterWhitespace
hi ExtraWhitespace gui=undercurl guifg=#dc8c6c guisp=#bc6c4c

" LeaderF
hi Lf_hl_match guifg=#ffcfaf
hi Lf_hl_matchRefine guifg=#efdcbc

" Vdebug
hi default DbgCurrentLine guifg=#ffffff guibg=#834048
hi default DbgCurrentSign guifg=#ffffff guibg=#834048
hi default DbgBreakptLine guifg=#ffffff guibg=#284F28
hi default DbgBreakptSign guifg=#ffffff guibg=#284F28

let g:colors_name="fixedzenburn"


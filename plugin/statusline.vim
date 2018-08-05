" Gui
let g:myconf_statusline_currentmode={
	\ 'n'  : 'N',
	\ 'no' : 'N·Operator Pending',
	\ 'v'  : 'V',
	\ 'V'  : 'V·Line',
	\ '' : 'V·Block',
	\ 's'  : 'Select',
	\ 'S'  : 'S·Line',
	\ '' : 'S·Block',
	\ 'i'  : 'I',
	\ 'R'  : 'R',
	\ 'Rv' : 'V·Replace',
	\ 'c'  : 'Command',
	\ 'cv' : 'Vim Ex',
	\ 'ce' : 'Ex',
	\ 'r'  : 'Prompt',
	\ 'rm' : 'More',
	\ 'r?' : 'Confirm',
	\ '!'  : 'Shell',
	\ 't'  : 'Terminal'
	\}

" Deferred
augroup myconf_statusline
	autocmd!
	autocmd BufNewFile,BufRead * let b:myconf_statusline_gitbranch = gitbranch#name()
	autocmd BufNewFile,BufRead * let b:myconf_statusline_hgbranch = hgbranch#name()
	autocmd BufAdd,BufWritePost,CmdlineLeave,InsertLeave,TextYankPost,CursorHold,TabEnter * let b:myconf_statusline_buffers_changed = 1
	autocmd VimEnter * call myconf#statusline#Init()
	" autocmd BufRead * if &buftype == 'help' | setlocal statusline=%!myconf#statusline#getDefaultLine() | endif
augroup END


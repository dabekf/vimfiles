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
	autocmd BufNewFile,BufRead * if exists('g:loaded_gitbranch') | let b:myconf_statusline_gitbranch = gitbranch#name() | endif
	autocmd BufNewFile,BufRead * if exists('g:loaded_hgbranch') | let b:myconf_statusline_hgbranch = hgbranch#name() | endif
	autocmd BufEnter,TabEnter,BufHidden,BufWritePost,CmdlineLeave,InsertLeave,TextYankPost,CursorHold * let t:myconf_statusline_buffers_changed = 1
	autocmd VimEnter * call myconf#statusline#Init()
	" autocmd BufRead * if &buftype == 'help' | setlocal statusline=%!myconf#statusline#getDefaultLine() | endif
augroup END


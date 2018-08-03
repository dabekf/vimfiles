" cache
augroup myconf_statusline
	autocmd!
	" autocmd BufNewFile,BufRead * let b:gitbranch = gitbranch#name()
	" autocmd BufNewFile,BufRead * let b:hgbranch = hgbranch#name()
	autocmd BufAdd,BufWritePost,CmdlineLeave,InsertLeave,TextYankPost,CursorHold,TabEnter * let b:myconf_statusline_buffers_changed = 1
	autocmd VimEnter * call myconf#statusline#Init()
augroup END


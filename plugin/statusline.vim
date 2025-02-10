" Deferred
augroup myconf_statusline
    autocmd!
    " autocmd BufNewFile,BufRead * if exists('g:loaded_gitbranch') | let b:myconf_statusline_gitbranch = gitbranch#name() | endif
    autocmd BufEnter,TabEnter,BufHidden,BufWritePost,CmdlineLeave,InsertLeave,TextChanged,TextChangedI,TextYankPost,CursorHold * let t:myconf_statusline_buffers_changed = 1
    autocmd VimEnter * call myconf#statusline#Init()
    autocmd BufWinEnter * if &buftype == 'nofile' | setlocal stl=%!myconf#statusline#SimpleLine() | endif
augroup END


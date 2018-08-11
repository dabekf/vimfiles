if !has('python3')
    echo 'In order to use sync2 plugin, you need +python or +python3 compiled vim'
	finish
endif

" nnoremap <F12> :call myconf#rsync#rsync('test')<CR>
" inoremap <F12> <C-o>:call myconf#rsync#rsync('test')<CR>
" nnoremap <S-F12> :call myconf#rsync#rsync('production')<CR>
" inoremap <S-F12> <C-o>:call myconf#rsync#rsync('production')<CR>
" nnoremap <C-F12> :call myconf#rsync#rsync('beta')<CR>
" inoremap <C-F12> <C-o>:call myconf#rsync#rsync('beta')<CR>

" nnoremap <silent> <M-F12> :if !exists('b:myconf_rsync') \| let b:myconf_rsync='test' \| else \| unlet b:myconf_rsync \| endif<CR>

augroup myconf_rsync
	autocmd!
	autocmd BufNewFile,BufRead ~/Projects/* call myconf#rsync#Init()
	autocmd BufNewFile,BufRead ~/Documents/Projects/redNet/* call myconf#rsync#Init()
	autocmd BufWritePost ~/Projects/* call myconf#rsync#Save()
	autocmd BufWritePost ~/Documents/Projects/redNet/* call myconf#rsync#Save()
augroup END

let s:plugin_path = escape(expand('<sfile>:p:h'), '\')
execute 'py3file ' . s:plugin_path . '/rsync.py'

nnoremap <silent> <F12> :call myconf#rsync#Upload(expand('%:p'), 'test')<CR>

" nnoremap <silent> <M-F12> :if !exists('b:myconf_rsync_target') \| let b:myconf_rsync_target='test' \| else \| unlet b:myconf_rsync_target \| endif<CR>



if !has('python3')
    echo 'In order to use sync2 plugin, you need +python or +python3 compiled vim'
	finish
endif

nnoremap <silent> <F12> :call myconf#rsync#Upload(expand('%:p'), 'test')<CR>
nnoremap <silent> <S-F12> :call myconf#rsync#Upload(expand('%:p'), 'production')<CR>
nnoremap <silent> <C-F12> :call myconf#rsync#Upload(expand('%:p'), 'beta')<CR>

nnoremap <silent> <M-F12> :call myconf#rsync#Cycle()<CR>

augroup myconf_rsync
	autocmd!
	autocmd BufNewFile,BufRead ~/Projects/* call myconf#rsync#Init()
	autocmd BufNewFile,BufRead ~/Documents/Projects/redNet/* call myconf#rsync#Init()
	autocmd BufWritePost ~/Projects/* call myconf#rsync#Save()
	autocmd BufWritePost ~/Documents/Projects/redNet/* call myconf#rsync#Save()
augroup END

let s:plugin_path = escape(expand('<sfile>:p:h'), '\')
execute 'py3file ' . s:plugin_path . '/rsync.py'


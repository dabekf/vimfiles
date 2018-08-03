nnoremap <F12> :call myconf#sync#Sync('test')<CR>
inoremap <F12> <C-o>:call myconf#sync#Sync('test')<CR>
nnoremap <S-F12> :call myconf#sync#Sync('production')<CR>
inoremap <S-F12> <C-o>:call myconf#sync#Sync('production')<CR>
nnoremap <C-F12> :call myconf#sync#Sync('beta')<CR>
inoremap <C-F12> <C-o>:call myconf#sync#Sync('beta')<CR>

nnoremap <silent> <M-F12> :if !exists('b:myconf_sync') \| let b:myconf_sync='test' \| else \| unlet b:myconf_sync \| endif<CR>

augroup myconf_sync
	autocmd!
	autocmd BufWritePost * call myconf#sync#Save()
augroup END

autocmd BufNewFile,BufRead ~/Projects/* let b:myconf_sync='test'
autocmd BufNewFile,BufRead ~/Documents/Projects/redNet/* let b:myconf_sync='test'


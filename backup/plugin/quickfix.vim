nnoremap <silent> <F9> :call myconf#quickfix#ToggleList("Location List", 'l')<CR>
map! <F9> <C-o><F9>
nnoremap <silent> <S-F9> :call myconf#quickfix#ToggleList("Quickfix List", 'c')<CR>
map! <S-F9> <C-o><S-F9>

nmap <silent> h :lfirs<CR>zv
nmap <silent> j :lprev<CR>zv
nmap <silent> k :lnext<CR>zv
nmap <silent> l :llast<CR>zv
nmap <silent> H :cfirs<CR>zv
nmap <silent> J :cprev<CR>zv
nmap <silent> K :cnext<CR>zv
nmap <silent> L :clast<CR>zv


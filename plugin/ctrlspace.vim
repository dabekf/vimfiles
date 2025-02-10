for index in [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
    execute "map <silent> <Esc>".index." :call myconf#ctrlspace#Buffer(".index.")<CR>"
    execute "imap <silent> <Esc>".index." <Esc>:call myconf#ctrlspace#Buffer(".index.")<CR>"
endfor

nmap <silent> <A-Left> :call myconf#ctrlspace#Go('up')<CR>
imap <silent> <A-Left><C-c>:call myconf#ctrlspace#Go('up')<CR>
nmap <silent> <A-Right> :call myconf#ctrlspace#Go('down')<CR>
imap <silent> <A-Right> <C-c>:call myconf#ctrlspace#Go('down')<CR>
nmap <silent> <Esc>, :call myconf#ctrlspace#Go('up')<CR>
imap <silent> <Esc>, <C-c>:call myconf#ctrlspace#Go('up')<CR>
nmap <silent> <Esc>. :call myconf#ctrlspace#Go('down')<CR>
imap <silent> <Esc>. <C-c>:call myconf#ctrlspace#Go('down')<CR>

noremap <silent> <Esc>q :call myconf#ctrlspace#Quit()<CR>
noremap! <silent> <Esc>q <C-c>:call myconf#ctrlspace#Quit()<CR>
noremap <silent> <Esc>w :call myconf#ctrlspace#Write()<CR>
noremap! <silent> <Esc>w <C-c>:call myconf#ctrlspace#Write()<CR>

map <Esc>E :call myconf#ctrlspace#ReloadAll()<CR>
map <Esc>e :e!<CR>

augroup myconf_ctrlspace
    autocmd!
    " Help as normal buffers
    autocmd BufRead * if &buftype == 'help' | setlocal bl | endif
augroup END

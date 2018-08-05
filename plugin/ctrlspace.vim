" set showtabline=0
if has("gui_running")
	" Settings for MacVim and Inconsolata font
	" let g:CtrlSpaceSymbols = { "File": "◯", "CTab": "▣", "Tabs": "▢" }
	let g:CtrlSpaceSymbols = { "WLoad": "↑", "WSave": "↓" }
endif
if executable("rg")
	let g:CtrlSpaceGlobCommand = 'rg %s -l --color=never -g ""'
endif
let g:CtrlSpaceFileEngine = "file_engine_windows_386.exe"
let g:CtrlSpaceSearchTiming = 250

map <silent> <C-Enter> <C-c>:CtrlSpace /<CR>
map! <silent> <C-Enter> <C-c>:CtrlSpace /<CR>

for index in [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
	execute "map <silent> <A-".index."> :call myconf#ctrlspace#Buffer(".index.")<CR>"
	execute "imap <silent> <A-".index."> <Esc>:call myconf#ctrlspace#Buffer(".index.")<CR>"
endfor

nmap <silent> <A-Left> :CtrlSpaceGoUp<CR>
imap <silent> <A-Left> <C-c>:CtrlSpaceGoUp<CR>
nmap <silent> <A-Right> :CtrlSpaceGoDown<CR>
imap <silent> <A-Right> <C-c>:CtrlSpaceGoDown<CR>

" nmap <silent> <A-]> <C-c>:tabnext<CR>
" nmap <silent> <A-[> <C-c>:tabprev<CR>

noremap <silent> <A-q> :call myconf#ctrlspace#Quit()<CR>
noremap! <silent> <A-q> <C-c>:call myconf#ctrlspace#Quit()<CR>
noremap <silent> <A-w> :call myconf#ctrlspace#Write()<CR>
noremap! <silent> <A-w> <C-c>:call myconf#ctrlspace#Write()<CR>

map <A-E> :call myconf#ctrlspace#ReloadAll()<CR>
map <A-e> :e!<CR>

augroup myconf_ctrlspace
	autocmd!
	" Help as normal buffers
	autocmd BufRead * if &buftype == 'help' | setlocal bl | endif
augroup END

" Better functions
function! myconf#ctrlspace#BufferList(tabnr)
	if !exists("g:CtrlSpaceLoaded")
		return []
	endif

	let bufferList     = []
	let singleList     = ctrlspace#buffers#Buffers(a:tabnr)
	let visibleBuffers = tabpagebuflist(a:tabnr)

	for i in keys(singleList)
		let i = str2nr(i)

		let bufname = bufname(i)
		let bufVisible = index(visibleBuffers, i) != -1
		let bufModified = (getbufvar(i, '&modified'))

		if !strlen(bufname) && (bufModified || bufVisible)
			let bufname = '[' . i . '*No Name]'
		endif

		if strlen(bufname)
			call add(bufferList, { "index": i, "text": bufname, "path": fnamemodify(bufname, ':p'), "visible": bufVisible, "modified": bufModified })
		endif
	endfor

	call sort(bufferList, function("myconf#ctrlspace#CompareByPath"))

	return bufferList
endfunction

function! myconf#ctrlspace#CompareByPath(a, b)
	let lhs = a:a.path
	let rhs = a:b.path
	if lhs < rhs
		return -1
	elseif lhs > rhs
		return 1
	else
		return 0
	endif
endfunction

" Moving
function! myconf#ctrlspace#Buffer(n)
	let buffers = myconf#ctrlspace#BufferList(tabpagenr())

	if exists("buffers[a:n - 1]")
		let index = buffers[a:n - 1]['index']
		exe "silent! b " . index
	endif
endf

" Closing
function! myconf#ctrlspace#Close(mode)
	if &buflisted == 0
		exe "Bdelete!"
	elseif exists("g:CtrlSpaceLoaded") && len(ctrlspace#api#BufferList(tabpagenr())) > 1
		if a:mode == 'write'
			exe "w"
		elseif a:mode == 'quit'
			exe "setlocal nomod"
		endif
		exe "silent CtrlSpace cq"
		" exe "Bdelete"
	else
		if a:mode == 'write'
			exe "wq"
		else
			exe "q!"
		endif
	endif
endf

" Reloading
function! myconf#ctrlspace#ReloadAll()
	if !exists("g:CtrlSpaceLoaded")
		return
	endif

	let currentTabnr = tabpagenr()
	let currentBufnr = bufnr('%')

	let tabs = ctrlspace#api#TabList()
	for tab in tabs
		exe "silent! tabn " . tab['index']
		let buffers = myconf#ctrlspace#BufferList(tab['index'])
		for buffer in buffers
			exe "silent b " . buffer['index']
			exe "e!"
		endfor
	endfor

	exe "silent tabn " . currentTabnr
	exe "silent b " . currentBufnr
	exe "redraw!"
	echo "All buffers reloaded."
endf

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
	if !&buflisted
		" Most unlisted buffers are special and shouldn't have navigation
		return
	endif

	let buffers = myconf#ctrlspace#BufferList(tabpagenr())

	if exists("buffers[a:n - 1]")
		let index = buffers[a:n - 1]['index']
		exe "silent! b " . index
	endif
endf

function! myconf#ctrlspace#Go(where)
	if !&buflisted
		" Most unlisted buffers are special and shouldn't have navigation
		return
	endif

	let buffers = myconf#ctrlspace#BufferList(tabpagenr())

	if len(buffers) <= 1
		return
	endif

	" if !&buflisted
	" 	exe "silent! b " . (a:where == 'up' ? buffers[-1]['index'] : buffers[0]['index'])
	" 	return
	" endif

	let bufnr = bufnr('%')
	let index = 0
	for buffer in buffers
		if buffer['index'] == bufnr
			if a:where == 'up'
				let newbufnr = (index == 0 ? buffers[-1]['index'] : buffers[index - 1]['index'])
			else
				let newbufnr = (index == len(buffers) - 1 ? buffers[0]['index'] : buffers[index + 1]['index'])
			endif
			exe "silent! b " . newbufnr
			return
		endif
		let index += 1
	endfor
endfunction

" Closing
function! myconf#ctrlspace#Close(mode)
	if !&buflisted
		" Most unlisted buffers are special and shouldn't have navigation
		return
	endif

	let buffers = myconf#ctrlspace#BufferList(tabpagenr())

	if exists("g:CtrlSpaceLoaded") && len(buffers) > 1
		if a:mode == 'write'
			exe "w"
		elseif a:mode == 'quit'
			exe "setlocal nomod"
		endif
		let bufnr = bufnr('%')

		if bufnr == buffers[-1]['index']
			silent exe 'buf ' . buffers[-2]['index']
			silent exe 'bdelete ' . bufnr
		else
			let index = 0
			for buf in buffers
				if buf['index'] == bufnr
					silent exe 'buf ' . buffers[index + 1]['index']
					silent exe 'bdelete ' . bufnr
					break
				endif
				let index += 1
			endfor
		endif
	else
		if a:mode == 'write'
			exe "wq"
		else
			exe "q!"
		endif
	endif
endf

function! myconf#ctrlspace#Quit()
	call myconf#ctrlspace#Close('quit')
endf

function! myconf#ctrlspace#Write()
	call myconf#ctrlspace#Close('write')
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

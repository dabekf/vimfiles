function! myconf#tags#Find()
	let l:dir = '..'

	while 1
		let l:tags = dir . '/tags'
		" echo 'tags=' . tags
		if filereadable(l:tags) && !isdirectory(l:tags)
			exe "setlocal tags+=" . l:tags
		endif

		let l:parent = fnamemodify(l:dir, ':p:h:t')
		" echo 'parent=' . parent
		if l:parent == 'Projects' || l:parent == ''
			break
		endif

		let l:dir = l:dir . '/..'
		" echo 'dir=' . dir
	endwhile
endf


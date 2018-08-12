function! myconf#tags#Find()
	let dir = '.'
	let markers = ['.git', '.hg', '.svn']

	while 1
		let tags = dir . '/.tags'
		" echo 'tags=' . tags
		if filereadable(tags)
			exe "setlocal tags+=" . tags[2:]
		endif

		for marker in markers
			" echo 'marker=' . dir . '/' . marker
			if isdirectory(dir . '/' . marker)
				" echo "found marker " . marker
				return
			endif
		endfor

		let parent = fnamemodify(dir, ':p:h:t')
		" echo 'parent=' . parent
		if parent == 'Projects' || parent == ''
			return
		endif

		let dir = dir . '/..'
		" echo 'dir=' . dir
	endwhile
endf


function! myconf#statusline#Mode()
	if (mode() =~# '\v(n|no)')
		let hi_0=2
	elseif (mode() =~# '\v(v|V)' || g:myconf_statusline_currentmode[mode()] ==# 'V·Block' || get(g:myconf_statusline_currentmode, mode(), '') ==# 't')
		let hi_0=3
	elseif (mode() ==# 'i')
		let hi_0=4
	else
		let hi_0=5
	endif
	return "%" . hi_0 . "* " . toupper(g:myconf_statusline_currentmode[mode()]) . " %*"
endf

function! myconf#statusline#Paste()
	if &paste == 1
		return " %1*PASTE%*"
	else
		return ""
	endif
endf

function! myconf#statusline#AsyncRunClear(timer) abort
	let g:asyncrun_status = ''
endf

function! myconf#statusline#AsyncRun() abort
	if !exists('g:asyncrun_status')
		return ''
	endif

	if g:asyncrun_status == "running"
		let hi_1 = "%6*"
		let hi_2 = "%*"
	elseif g:asyncrun_status == "failure"
		let hi_1 = "%7*"
		let hi_2 = "%*"
	elseif g:asyncrun_status == "success"
		let hi_1 = ""
		let hi_2 = ""
		call timer_start(200, 'myconf#statusline#AsyncRunClear')
	else
		let hi_1 = ""
		let hi_2 = ""
	endif
	return "%( " . hi_1 . "[ar:%{g:asyncrun_status}]%)" . hi_2
endf

function! myconf#statusline#Rsync() abort
	if exists("b:myconf_rsync_target") && b:myconf_rsync_target != ""
		let lines = []

		if b:myconf_rsync_status == 'error'
			let lines += ["%7*"]
		endif

		let lines += [" [⇒:", b:myconf_rsync_target]

		if b:myconf_rsync_status == 'running'
			let lines += [":⎋"]
		elseif b:myconf_rsync_status == 'error'
			let lines += [":×"]
		elseif b:myconf_rsync_status == 'done'
			let lines += [":✓"]
		endif

		let lines += ["]"]

		if b:myconf_rsync_status == 'error'
			let lines += ["%*"]
		endif

		return join(lines, "")
	else
		return ""
	endif
endf

function! myconf#statusline#HowLong() abort
	if exists('b:howLong') && b:howLong > 0
		if b:howLong < 0.01
			let time = printf('%.2f', b:howLong * 1000) . "ms"
		else
			let time = printf('%.2f', b:howLong) . "s"
		endif
		return " [⎋:" . time . "]"
	else
		return ""
	endif
endfunction

function! myconf#statusline#LinterStatus() abort
	let l:counts = ale#statusline#Count(bufnr(''))

	let l:all_errors = l:counts.error + l:counts.style_error
	let l:all_non_errors = l:counts.total - l:all_errors

	return l:counts.total == 0 ? ' [✓]' : ' %7*[' . printf(
	\   '×:%d ◬:%d',
	\   all_errors,
	\   all_non_errors
	\) . ']%*'
endfunction

function! myconf#statusline#Gitbranch() abort
	if !exists('b:myconf_statusline_gitbranch') || b:myconf_statusline_gitbranch == 'master'
		return ''
	endif
	return b:myconf_statusline_gitbranch != '' ? ' %([⅄:' . b:myconf_statusline_gitbranch . ']%)' : ''
endf

function! myconf#statusline#Hgbranch() abort
	if !exists('b:myconf_statusline_hgbranch') || b:myconf_statusline_hgbranch == 'default'
		return ''
	endif
	return b:myconf_statusline_hgbranch != '' ? ' %([⅄:' . b:myconf_statusline_hgbranch . ']%)' : ''
endf

function! myconf#statusline#BuffersInit()
	if exists('g:CtrlSpaceLoaded')
		let result = []
		let visible = 0
		for item in myconf#ctrlspace#BufferList(tabpagenr())
			let text = ""

			if match(item.text, "NERD_tree") != -1
				continue
			endif

			if item.visible
				let text .= "%8*"
				let visible = 1
			endif

			" let name = fnamemodify(item.text, ":p:h:t")[0] . '/' . fnamemodify(item.text, ":t")
			let dir = fnamemodify(item.text, ":p:h:t")[0]
			let file = fnamemodify(item.text, ":t:r")
			let ext = fnamemodify(item.text, ":t:e")

			let maxlen = 12

			if len(file) > maxlen && len(file) != maxlen + 1
				let file = substitute(file, '\v^(.{' . maxlen . '}).+$', '\1…', '')
			endif

			let name = dir . '/' . file
			if ext != ''
				let name = name . '.' . ext
			endif

			" if name == ''
			" 	let name = 'buffer-' . item.index
			" endif

			let text .= name

			if item.modified
				let text .= "+"
			endif

			if item.visible
				let text .= "%*"
			endif

			let result += [text]
		endfor

		if 1 || len(result) > 0 " && visible == 1
			" return "%( %*%<" . join(result, " ") . "%)"
			return " %*%<" . join(result, " ") . ""
		else
			" return "%( %8*%f%m%*%)"
			return " %8*%f%m%*"
		endif
	else
		" return "%( %f%)"
		return " %f"
	endif
endf

function! myconf#statusline#Buffers()
	" return exists('b:bufferlist') ? b:bufferlist : " %f"
	if !exists('b:myconf_statusline_buffers_changed') || b:myconf_statusline_buffers_changed == 1
		let b:myconf_statusline_buffers_changed = 0
		let b:myconf_statusline_buffers = myconf#statusline#BuffersInit()
	endif

	return b:myconf_statusline_buffers
endf

function! myconf#statusline#FileFormat()
	if &ff == "unix"
		return ''
	else
		return ' [%{&ff}]'
	endif
endf

function! myconf#statusline#getDefaultLine()
	return "%<%F\ %h%m%r%w%y\ %{&ff}\ %=\ %{(&paste==0)?'':'P'}\ char:%b\(0x%B\)\ col:%c%V\ lin:%l\,%L\ pos:%o\ %P"
endfunction

function! myconf#statusline#getStatusLine()
	let sl = myconf#statusline#Mode()
	let sl .= myconf#statusline#Paste()
	let sl .= myconf#statusline#Buffers()
	let sl .= " %= "
	" let sl .= "%( %{tagbar#currenttag('<%s>', '', 'f')}%)"
	if exists('g:loaded_ale')
		let sl .= myconf#statusline#LinterStatus()
	endif
	let sl .= myconf#statusline#Gitbranch()
	let sl .= myconf#statusline#Hgbranch()
	" let sl .= myconf#statusline#HowLong()
	let sl .= myconf#statusline#AsyncRun()
	let sl .= myconf#statusline#Rsync()
	let sl .= "%( %h%m%r%w%y%)"
	let sl .= myconf#statusline#FileFormat()
	let sl .= " ch:%b\(0x%B\)"
	let sl .= " col:%c%V"
	let sl .= " lin:%l\/%L"
	let sl .= " %P"

	return sl
endf

function! myconf#statusline#Init()
	" Fallback
	if exists('g:CtrlSpaceLoaded')
		set statusline=%!myconf#statusline#getStatusLine()
	else
		set statusline=%!myconf#statusline#getDefaultLine()
	endif
endfunction


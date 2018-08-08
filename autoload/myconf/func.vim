" Matching parentheses
function! myconf#func#ToggleMatchParen()
	if exists("g:loaded_matchparen")
		exe "NoMatchParen"
		echo "Stopped matching parentheses"
	else
		exe "DoMatchParen"
		echo "Now matching parentheses"
	endif
endf

" Folding marker generator
" @deprecated Too slow, conflicts with andymass/vim-matchup
function! myconf#func#Markers(pattern)
	exe 'normal mZ'
	call cursor(1,1)
	while search(a:pattern, "We") > 0
		exe 'normal zf%'
		exe 'normal zo'
	endwhile
	exe 'normal zM'
	exe "normal g'Z"
"     exe 'silent! normal zo'
endf

" Times the number of times a particular command takes to execute the specified number of times (in seconds).
function! myconf#func#HowLong(command, numberOfTimes)
	" We don't want to be prompted by a message if the command being tried is
	" an echo as that would slow things down while waiting for user input.
	let more = &more
	set nomore
	let startTime = reltime()
	for i in range(a:numberOfTimes)
		execute a:command
	endfor
	let result = str2float(split(reltimestr(reltime(startTime)))[0])
	let &more = more
	return result
endfunction

function! myconf#func#HowLongVar(command, numberOfTimes)
	let b:howLong = HowLong(a:command, a:numberOfTimes)
endfunction

function! myconf#func#HowLongRange(command, numberOfTimes) range
	" We don't want to be prompted by a message if the command being tried is
	" an echo as that would slow things down while waiting for user input.
	let more = &more
	set nomore
	let startTime = reltime()
	for i in range(a:numberOfTimes)
		execute a:firstline . "," . a:lastline . a:command
	endfor
	let result = str2float(split(reltimestr(reltime(startTime)))[0])
	let &more = more
	return result
endfunction

function! myconf#func#HowLongVarRange(command, numberOfTimes) range
	let b:howLong = HowLongRange(a:command, a:numberOfTimes)
endfunction

" When editing a file, always jump to the last cursor position
function! myconf#func#JumpToLastPosition()
	if ! exists("g:leave_my_cursor_position_alone")
		if line("'\"") > 0 && line ("'\"") <= line("$")
			normal g`"
			silent! normal zv
"			let v:errmsg = ""
			normal zz
		endif
	endif
endf

function! myconf#func#ToggleClipboard()
	if !exists("b:clipboard")
		let b:clipboard = &cb
		set cb=exclude:.*
	else
		let &cb = b:clipboard
		unlet b:clipboard
	endif
endf

function! myconf#func#StartProfiling()
	profile start $myconf/profile.log
	profile func *
	profile file *
endfunction


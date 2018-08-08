function! ft#javascript#fold(lnum)
	let line0 = getline(a:lnum - 1)
	let line1 = getline(a:lnum)
	let line2 = getline(a:lnum + 1)

	if line0 =~# '\vfunction\(.{-}[^{]$'
		if line1 =~ '{\s*$'
			return '>1'
		endif
	elseif line1 =~ '},$'
		return '<1'
	endif
	return '='
endfunction


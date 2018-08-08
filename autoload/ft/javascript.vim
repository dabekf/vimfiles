function! ft#javascript#Fold(lnum)
	let line0 = getline(a:lnum - 1)
	let line1 = getline(a:lnum)
	let line2 = getline(a:lnum + 1)

	if line0 =~# '\v^\t+.{-}function\(.{-}[^{]$' && line1 =~ '{\s*$' && foldlevel(line0) < 1
		return '>1'
	elseif line1 =~# '\v^\t+.{-}function\(.{-} \{$' && foldlevel(line0) < 1
		return '>1'
	elseif line1 =~ '\v^\t+},$' && line2 =~ "^$" " && foldlevel(line0) == 0
		return '<1'
	endif
	return '='
endfunction


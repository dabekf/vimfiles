function! FixCssColours() range
    let pat = '\v#([A-Z0-9]{6}|[A-Z0-9]{3})'
    let repl = '#\L\1\E'
    silent! execute (a:firstline) . "," . a:lastline . 's:' . pat . ':' . repl . ':g'
endfunction

nnoremap <buffer> <Leader>c :%call FixCssColours()<CR>
vnoremap <buffer> <Leader>c :call FixCssColours()<CR>


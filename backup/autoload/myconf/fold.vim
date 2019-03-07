" Folding marker generator
function! myconf#fold#Markers(pattern)
    let view = winsaveview()
    call cursor(1, 1)

    while search(a:pattern, "We") > 0
        exe 'normal zfa}'
    endwhile

    call winrestview(view)
endf

" Different approach, probably slower than Markers
function! myconf#fold#Markers2(function, foldlevel)
    let view = winsaveview()
    call cursor(1, 1)

    let lastline = line('$')
    while 1
        let linenr = line('.')
        let foldexpr = a:function(linenr)
        if foldexpr == '>1'
            " echo 'fold found on line ' . linenr
            exe 'silent normal zfa}zo]z'
        endif
        call cursor(line('.') + 1, 1)
        if line('.') >= lastline
            break
        endif
    endwhile
    call winrestview(view)
    exe 'setlocal foldlevel=' . a:foldlevel
endfunction


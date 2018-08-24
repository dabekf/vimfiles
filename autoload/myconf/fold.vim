" Folding marker generator
function! myconf#fold#Markers(pattern)
    let pos = getpos('.')
    call cursor(1, 1)

    while search(a:pattern, "We") > 0
        exe 'normal zfa}'
    endwhile

    call setpos('.', pos)
    normal zv
endf

" Different approach, probably slower than Markers
function! myconf#fold#Markers2(function, foldlevel)
    let pos = getpos('.')
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
    call setpos('.', pos)
    exe 'setlocal foldlevel=' . a:foldlevel
endfunction


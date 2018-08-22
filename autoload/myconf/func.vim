" Matching parentheses
function! myconf#func#ToggleMatchParen()
    if !exists("b:matchup_matchparen_enabled") || b:matchup_matchparen_enabled == 1
        let b:matchup_matchparen_enabled = 0
        let b:matchup_matchparen_fallback = 0
        echo "Stopped matching parentheses"
    else
        let b:matchup_matchparen_enabled = 1
        let b:matchup_matchparen_fallback = 1
        echo "Now matching parentheses"
    endif
endf

" Folding marker generator
function! myconf#func#Markers(pattern)
    mark z
    call cursor(1, 1)

    while search(a:pattern, "We") > 0
        exe 'normal zfa}'
    endwhile
    exe "silent normal g'z"
    delm z
endf

" Different approach, probably slower than Markers
function! myconf#func#Markers2(function, foldlevel)
    mark z
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
    exe 'silent normal g`z'
    exe 'setlocal foldlevel=' . a:foldlevel
    delm z
endfunction

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
    if !exists("b:leave_my_cursor_position_alone")
        if line("'\"") > 0 && line ("'\"") <= line("$")
            normal g`"
            silent! normal zv
            let b:leave_my_cursor_position_alone = 1
            " normal zz
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

function! myconf#func#Retab() range abort
    let pat = '\v( {' . &ts . '})+'
    let repl = '\=repeat("\t", strlen(submatch(0)) / &ts)'
    silent! execute (a:firstline + 1) . "," . a:lastline . 's:' . pat . ':' . repl . ':g'
endfunction

function! myconf#func#Untab() range abort
    let pat = '\v(\t)+'
    let repl = '\=repeat(" ", strlen(submatch(0)) * &ts)'
    silent! execute (a:firstline + 1) . "," . a:lastline . 's:' . pat . ':' . repl . ':g'
endfunction


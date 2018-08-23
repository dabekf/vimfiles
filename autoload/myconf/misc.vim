" Matching parentheses
function! myconf#misc#ToggleMatchParen()
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

" Times the number of times a particular command takes to execute the specified number of times (in seconds).
function! myconf#misc#HowLong(command, numberOfTimes)
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

function! myconf#misc#HowLongVar(command, numberOfTimes)
    let b:howLong = HowLong(a:command, a:numberOfTimes)
endfunction

function! myconf#misc#HowLongRange(command, numberOfTimes) range
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

function! myconf#misc#HowLongVarRange(command, numberOfTimes) range
    let b:howLong = HowLongRange(a:command, a:numberOfTimes)
endfunction

" When editing a file, always jump to the last cursor position
function! myconf#misc#JumpToLastPosition()
    if !exists("b:leave_my_cursor_position_alone")
        if line("'\"") > 0 && line ("'\"") <= line("$")
            normal g`"
            silent! normal zv
            let b:leave_my_cursor_position_alone = 1
            " normal zz
        endif
    endif
endf

function! myconf#misc#ToggleClipboard()
    if !exists("b:clipboard")
        let b:clipboard = &cb
        set cb=exclude:.*
    else
        let &cb = b:clipboard
        unlet b:clipboard
    endif
endf

function! myconf#misc#StartProfiling()
    profile start $myconf/profile.log
    profile func *
    profile file *
endfunction

" Executes normal "NXXX" or regular "RXXX" commands,
" then restores the cursor position
function! myconf#misc#RunInPlace(cmds)
    let pos = getpos('.')
    for cmd in a:cmds
        if cmd[0] == 'N'
            exe 'normal ' . cmd[1:]
        elseif cmd[0] == 'R'
            exe cmd[1:]
        else
            throw "Wrong mode"
        endif
    endfor
    call setpos('.', pos)
endfunction


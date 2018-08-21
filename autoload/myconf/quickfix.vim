" http://vim.wikia.com/wiki/Toggle_to_open_or_close_the_quickfix_window

function! myconf#quickfix#GetBufferList()
    redir => buflist
    silent! ls!
    redir END
    return buflist
endfunction

function! myconf#quickfix#ToggleList(bufname, pfx)
    let buflist = myconf#quickfix#GetBufferList()
    for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
        if bufwinnr(bufnum) != -1
            exec(a:pfx . 'close')
            return
        endif
    endfor
    if a:pfx == 'l' && len(getloclist(0)) == 0
        echohl ErrorMsg
        echo "Location List is Empty."
        return
    endif
    let winnr = winnr()
    exec(a:pfx . 'open')
    if winnr() != winnr
        wincmd p
    endif
endfunction


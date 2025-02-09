" Gui
let s:myconf_statusline_currentmode={
    \ 'n'  : 'N',
    \ 'no' : 'N·Operator Pending',
    \ 'v'  : 'V',
    \ 'V'  : 'V·Line',
    \ '' : 'V·Block',
    \ 's'  : 'Select',
    \ 'S'  : 'S·Line',
    \ '' : 'S·Block',
    \ 'i'  : 'I',
    \ 'R'  : 'R',
    \ 'Rv' : 'V·Replace',
    \ 'c'  : 'Command',
    \ 'cv' : 'Vim Ex',
    \ 'ce' : 'Ex',
    \ 'r'  : 'Prompt',
    \ 'rm' : 'More',
    \ 'r?' : 'Confirm',
    \ '!'  : 'Shell',
    \ 't'  : 'Terminal'
    \}

function! myconf#statusline#Mode()
    if (mode() =~# '\v(n|no)')
        let hiName = 'MyconfStlModeNormal'
    elseif (mode() =~# '\v(v|V)' || s:myconf_statusline_currentmode[mode()] ==# 'V·Block' || get(s:myconf_statusline_currentmode, mode(), '') ==# 't')
        let hiName = 'MyconfStlModeVisual'
    elseif (mode() ==# 'i')
        let hiName = 'MyconfStlModeInsert'
    elseif (mode() ==# 'R')
        let hiName = 'MyconfStlModeReplace'
    else
        let hiName = 'MyconfStlModeDefault'
    endif
    let paste = &paste == 1 ? '·PASTE' : ''
    "return "%#" . hiName . "Str# " . toupper(s:myconf_statusline_currentmode[mode()]) . paste . "→ %#" . hiName . "Rev#%*"
    return "%#" . hiName . "Str# " . toupper(s:myconf_statusline_currentmode[mode()]) . paste . "→ %*"
endf

function! myconf#statusline#AsyncRunClear(timer) abort
    let g:asyncrun_status = ''
endf

function! myconf#statusline#AsyncRun() abort
    if !exists('g:asyncrun_status')
        return ''
    endif

    if g:asyncrun_status == "running"
        let hi_1 = "%#MyconfStlRunning#"
        let hi_2 = "%*"
    elseif g:asyncrun_status == "failure"
        let hi_1 = "%#MyconfStlError#"
        let hi_2 = "%*"
    elseif g:asyncrun_status == "success"
        let hi_1 = ""
        let hi_2 = ""
        call timer_start(200, 'myconf#statusline#AsyncRunClear')
    else
        let hi_1 = ""
        let hi_2 = ""
    endif
    return "%( " . hi_1 . "ar:%{g:asyncrun_status}%)" . hi_2
endf

function! myconf#statusline#SftpSync() abort
    if exists("b:sftpsync_target") && b:sftpsync_target != "" && exists("b:sftpsync_status")
        let lines = []

        if b:sftpsync_status == 'error'
            let lines += ["%#MyconfStlError#"]
        endif

        let lines += [" ⇒:", b:sftpsync_target]

        if b:sftpsync_status == 'running'
            let lines += [":"]
        elseif b:sftpsync_status == 'error'
            let lines += [":×"]
        elseif b:sftpsync_status == 'done'
            let lines += [":"]
        endif

        if b:sftpsync_status == 'error'
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
        return " T:" . time . ""
    else
        return ""
    endif
endfunction

function! myconf#statusline#LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? ' L:' : ' %#MyconfStlError#L:' . printf(
    \   '%de,%dw',
    \   all_errors,
    \   all_non_errors
    \) . '%*'
endfunction

function! myconf#statusline#Gitbranch() abort
    if !exists('b:myconf_statusline_gitbranch') || b:myconf_statusline_gitbranch == 'master'
        return ''
    endif
    return b:myconf_statusline_gitbranch != '' ? ' %(:' . b:myconf_statusline_gitbranch . '%)' : ''
endf

function! myconf#statusline#BuffersInit()
    if exists('g:CtrlSpaceLoaded')
        let result = []
        let visible = -1
        let index = 0
        let buffers = myconf#ctrlspace#BufferList(tabpagenr())
        for item in buffers
            let text = ""

            if match(item.text, "NERD_tree") != -1
                continue
            endif

            if item.visible
                let text .= "%#MyconfStlActiveBuffer#"
                let visible = index
            else
                let text .= "%#MyconfStlInactiveBuffer#"
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
            "     let name = 'buffer-' . item.index
            " endif

            let text .= name

            if item.modified
                let text .= "+"
            endif

            let text .= "%*"

            let result += [text]
            let index += 1
        endfor

        if visible != -1 && len(result) > 0
            if visible < len(buffers) / 2
                let result[len(buffers) / 2] .= '%<'
            else
                let result[0] = '%<' . result[0]
            endif

            return " %*" . join(result, " ") . ""
        else
            return s:myconf_statusline_default_buffer_item
        endif
    else
        return s:myconf_statusline_default_buffer_item
    endif
endf

function! myconf#statusline#Buffers()
    " return exists('b:bufferlist') ? b:bufferlist : " %f"
    if !exists('t:myconf_statusline_buffers_changed') || t:myconf_statusline_buffers_changed == 1
        let t:myconf_statusline_buffers_changed = 0
        let t:myconf_statusline_buffers = myconf#statusline#BuffersInit()
    endif

    return t:myconf_statusline_buffers
endf

function! myconf#statusline#FileFormat()
    if &ff == "unix"
        return ""
    else
        return " %{&ff}"
    endif
endf

function! myconf#statusline#FileType()
    if &ft == ""
        return ""
    else
        return "%{','.&ft}"
    endif
endf

function! myconf#statusline#ExpandTab()
    if &et
        return "  ()"
    else
        return "  (×)"
    endif
endfunction

function! myconf#statusline#QuickFixTitle()
    return exists('w:quickfix_title') ? ' ' . w:quickfix_title : ''
endfunction

function! myconf#statusline#RightSide()
    if winwidth(0) < s:myconf_statusline_max_screen_width
        return ' %P'
    endif

    let sl = ""
    let sl .= myconf#statusline#ExpandTab()
    let sl .= "%( %M%R%W" . myconf#statusline#FileType() . "%)"
    let sl .= myconf#statusline#FileFormat()
    let sl .= " ch:%b\(0x%B\)"
    let sl .= " ║:%c%V"
    let sl .= " ═:%l\/%L"
    let sl .= " %P"

    return sl
endfunction

function! myconf#statusline#SimpleLine()
    let sl = myconf#statusline#Mode()
    let sl .= s:myconf_statusline_default_buffer_item
    let sl .= " %= "
    let sl .= myconf#statusline#RightSide()

    return sl
endfunction

function! myconf#statusline#QuickFixLine()
    let sl = '%<%F'
    let sl .= myconf#statusline#QuickFixTitle()
    let sl .= " %= "
    let sl .= myconf#statusline#RightSide()

    return sl
endfunction

function! myconf#statusline#DefaultLine()
    let buffers = myconf#statusline#Buffers()
    if buffers != s:myconf_statusline_default_buffer_item
        let sl = myconf#statusline#Mode()
        if winwidth(0) == s:myconf_statusline_max_screen_width
            let sl .= buffers
        else
            let sl .= s:myconf_statusline_default_buffer_item
        endif

        let sl .= " %= "
        if exists('g:loaded_ale')
            let sl .= myconf#statusline#LinterStatus()
        endif
        let sl .= myconf#statusline#Gitbranch()
        let sl .= myconf#statusline#AsyncRun()
        if exists('g:sftpsync_loaded')
            let sl .= myconf#statusline#SftpSync()
        endif
    else
        let sl = myconf#statusline#Mode()
        let sl .= buffers
        let sl .= " %= "
    endif

    let sl .= myconf#statusline#RightSide()

    return sl
endf

function! myconf#statusline#Init()
    " Fallback
    let s:myconf_statusline_max_screen_width = winwidth(0)
    let s:myconf_statusline_default_buffer_item = " %#MyconfStlActiveBuffer#\★%t%m%*"

    if exists('g:CtrlSpaceLoaded')
        set statusline=%!myconf#statusline#DefaultLine()
    else
        set statusline=%!myconf#statusline#SimpleLine()
    endif
endfunction

function! myconf#sonokai#CustomColors() abort
    " guibg is pallete.bg0
    let l:palette = sonokai#get_palette('shusia', {})
    "call sonokai#highlight('SpecialKey', l:palette.orange, l:palette.none)
    call sonokai#highlight('MyconfStlActiveBuffer', l:palette.fg, l:palette.bg3)
    call sonokai#highlight('MyconfStlInactiveBuffer', l:palette.grey, l:palette.bg3)
    call sonokai#highlight('MyconfStlModeNormalStr', l:palette.black, l:palette.bg_green)
    call sonokai#highlight('MyconfStlModeVisualStr', l:palette.fg, ['firebrick3', 196])
    call sonokai#highlight('MyconfStlModeInsertStr', ['yellow', 11], ['forestgreen', 28])
    call sonokai#highlight('MyconfStlModeReplaceStr', ['yellow', 11], ['royalblue', 63])
    call sonokai#highlight('MyconfStlModeDefaultStr', ['yellow', 11], ['darkorchid', 98])
    call sonokai#highlight('MyconfStlRunning', l:palette.yellow, l:palette.bg0)
    call sonokai#highlight('MyconfStlError', l:palette.red, l:palette.bg0)
endfunction

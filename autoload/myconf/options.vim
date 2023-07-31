function! myconf#options#SetGlobalOptions()
    " CtrlSpace
    let g:CtrlSpaceDefaultMappingKey = "<F5>"
    let g:CtrlSpaceFileEngine = "file_engine_linux_amd64.exe"
    let g:CtrlSpaceSearchTiming = 250
    if executable("rg")
        let g:CtrlSpaceGlobCommand = 'rg "" -l --color=never'
    endif
    let g:CtrlSpaceSymbols = { "WLoad": "↑", "WSave": "↓", "File": "○", "CTab": "■", "Tabs": "□", "CS": "#", "Zoom": "" }
    let g:CtrlSpaceUseMouseAndArrowsInTerm = 1

    if $USERNAME == 'Fil'
        let g:CtrlSpaceUseUnicode = 0
    endif
endfunction

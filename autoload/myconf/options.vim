function! myconf#options#SetGlobalOptions()
    " CtrlSpace
    let g:CtrlSpaceFileEngine = "file_engine_linux_amd64.exe"
    let g:CtrlSpaceSearchTiming = 250
    if executable("rg")
        let g:CtrlSpaceGlobCommand = 'rg "" -l --color=never'
    endif
    let g:CtrlSpaceSymbols = { "WLoad": "↑", "WSave": "↓", "File": "○", "CTab": "■", "Tabs": "□" }
    let g:CtrlSpaceUseMouseAndArrowsInTerm = 1
    let g:CtrlSpaceWorkspaceFile = ""
endfunction

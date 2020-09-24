function! myconf#options#SetGlobalOptions()
    " CtrlSpace
    let g:CtrlSpaceFileEngine = "file_engine_linux_amd64.exe"
    let g:CtrlSpaceSearchTiming = 250
    if executable("rg")
        let g:CtrlSpaceGlobCommand = 'rg "" -l --color=never'
    endif
    let g:CtrlSpaceSymbols = { "WLoad": "↑", "WSave": "↓", "File": "◯", "CTab": "▣", "Tabs": "▢" }

    let g:CtrlSpaceKeys = { "Buffer":
        \{
            \"Up": "ctrlspace#keys#common#Up",
            \"Down": "ctrlspace#keys#common#Down"
        \}
    \}

    " Vdebug
    if !exists('g:vdebug_options')
      let g:vdebug_options = {}
    endif
    let g:vdebug_options.break_on_open = 0
    let g:vdebug_options.ide_key = 'fdabek-dbg'
    let g:vdebug_options.marker_default = '⬦'
    let g:vdebug_options.marker_closed_tree = '▸'
    let g:vdebug_options.marker_open_tree = '▾'

    if $USERNAME == 'Fil'
        let g:vdebug_options.path_maps = {
        \   "/home/www/fd3.to5.tabelaofert.pl": "C:\\Users\\Fil\\Documents\\Projects\\fd3.to5.tabelaofert.pl"
        \}
    else
        let g:vdebug_options.path_maps = {
        \   "/home/www/fd3.to5.tabelaofert.pl": "C:\\Users\\fdabek\\Projects\\fd3.to5.tabelaofert.pl"
        \}
    endif
endfunction

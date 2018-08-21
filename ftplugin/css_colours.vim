function! FixCssColours()
    exe "%s@ #\\([A-Z0-9]\\{6}\\)@ #\\L\\1\\E@e"
endf
map <Leader>c :call FixCssColours()<CR>



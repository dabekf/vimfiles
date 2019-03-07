augroup myconf_tags
    autocmd!
    autocmd BufNewFile,BufRead ~/Projects/* call myconf#tags#Find()
    autocmd BufNewFile,BufRead ~/Documents/Projects/redNet/* call myconf#tags#Find()
augroup END


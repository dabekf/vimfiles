" Extra autocommands
augroup myconf_autocmd
    autocmd!

    " When editing a crontab file, set backupcopy to yes rather than auto. See :help crontab and bug 53437.
    autocmd FileType crontab setlocal backupcopy=yes

    " phtml templates
    autocmd BufNewFile,BufRead *.phtml setlocal filetype=phtml
    autocmd BufNewFile,BufRead *.css.phtml setlocal filetype=css
    autocmd BufNewFile,BufRead .htaccess.* setlocal filetype=apache

    " csv no-wrapping
    autocmd BufNewFile,BufRead *.csv setlocal nowrap

    " PHP
    autocmd BufNewFile,BufRead *.php setlocal nobomb
    autocmd BufRead *.php call myconf#fold#Markers('function \?[a-zA-Z0-9_ ]*(.*)\(:[a-zA-Z0-9_]\+\)\?\s*\n\s*{')
    " autocmd BufNewFile,BufRead *.php call myconf#fold#Markers2(function('ft#php#Fold'), 0)

    " Python
    autocmd BufNewFile,BufRead *.py setlocal foldlevel=1
augroup END


" sftpsync config
let g:sftpsync_host_keys_file = 'C:/Cygwin64/home/$USERNAME/.ssh/known_hosts'
let g:sftpsync_private_key_file = 'C:/Cygwin64/home/$USERNAME/.ssh/id_rsa'
let g:sftpsync_echo_time = 0
let g:sftpsync_use_statusline = 1

let g:sftpsync_projects = {
\    'to5': {
\        'source': '^.+/Projects/(redNet/)?([a-z0-9]+)\.to5\.tabelaofert\.pl',
\        'destination': {
\            'test': {
\                'directory': '/home/www/\2.to5.tabelaofert.pl',
\                'hosts': ['fdabek@inzynier'],
\            },
\            'production': {
\                'directory': '/home/www/to5.tabelaofert.pl',
\                'hosts': ['fdabek@flap', 'fdabek@flip', 'fdabek@aragon'],
\            },
\        }
\    },
\    'importer': {
\        'source': '^.+/Projects/(redNet/)?importer\.tabelaofert\.pl',
\        'destination': {
\            'test': {
\                'directory': '/home/www/importer.tabelaofert.pl',
\                'hosts': ['fdabek@inzynier'],
\            },
\            'production': {
\                'directory': '/home/www/importer.tabelaofert.pl',
\                'hosts': ['fdabek@aragon'],
\            },
\        }
\    },
\    'optimage': {
\        'source': '^.+/Projects/(redNet/)?([a-z0-9]+)\.optimage',
\        'destination': {
\            'test': {
\                'directory': '/home/www/\2.optimage',
\                'hosts': ['fdabek@inzynier'],
\            },
\            'production': {
\                'directory': '/home/www/optimage',
\                'hosts': ['fdabek@zielony'],
\            },
\        }
\    },
\    'polskikoszyk': {
\        'source': '^.+/Projects/(redNet/)?([a-z0-9]+)\.polskikoszyk\.pl',
\        'destination': {
\            'test': {
\                'directory': '/home/www/\2.polskikoszyk.pl',
\                'hosts': ['fdabek@inzynier'],
\            },
\            'production': {
\                'directory': '/home/www/polskikoszyk.pl',
\                'hosts': ['fdabek@zielony'],
\            },
\        }
\    },
\    'content': {
\        'source': '^.+/Projects/(redNet/)?content\.tabelaofert\.pl',
\        'destination': {
\            'test': {
\                'directory': '/home/www/content.tabelaofert.pl',
\                'hosts': ['fdabek@inzynier'],
\            },
\            'production': {
\                'directory': '/home/www/content.tabelaofert.pl',
\                'hosts': ['fdabek@aragon'],
\            },
\        }
\    },
\    'crm': {
\        'source': '^.+/Projects/(redNet/)?crm\.rednet\.pl',
\        'destination': {
\            'test': {
\                'directory': '/home/www/crm',
\                'hosts': ['fdabek@inzynier'],
\            },
\        }
\    },
\    'thebuggenie': {
\        'source': '^.+/Projects/thebuggenie',
\        'destination': {
\            'test': {
\                'directory': '/home/www/bug.rednetproperty.com',
\                'hosts': ['fdabek@inzynier'],
\            },
\            'production': {
\                'directory': '/home/www/bug.rednetproperty.com',
\                'hosts': ['fdabek@aragon'],
\            },
\        }
\    },
\}

if exists('g:sftpsync_loaded')
    nnoremap <silent> <F12> :call sftpsync#Upload(expand('%:p'), 'test')<CR>
    nnoremap <silent> <S-F12> :call sftpsync#Upload(expand('%:p'), 'production')<CR>
    nnoremap <silent> <C-F12> :call sftpsync#Upload(expand('%:p'), 'beta')<CR>

    nnoremap <silent> <M-F12> :call sftpsync#Cycle(['test', '', 'production'])<CR>

    augroup sftpsync
        autocmd!
        autocmd BufNewFile,BufRead ~/Projects/* call sftpsync#Init('test', 1)
        autocmd BufNewFile,BufRead ~/Documents/Projects/redNet/* call sftpsync#Init('test', 1)
        autocmd BufWritePost ~/Projects/* call sftpsync#Upload()
        autocmd BufWritePost ~/Documents/Projects/redNet/* call sftpsync#Upload()
    augroup END
endif

" call myconf#fold#Markers('[:=] function \?([a-zA-Z0-9,_\$ ]*)\s*\n\s*{')
" setlocal foldexpr=ft#javascript#Fold(v:lnum)
" setlocal foldmethod=expr

let g:used_javascript_libs = 'jquery,lodash,underscore,react'


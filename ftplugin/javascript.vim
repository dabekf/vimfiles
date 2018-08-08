" call myconf#func#Markers('[:=] function \?([a-zA-Z0-9,_\$ ]*)\s*\n\s*{')
setlocal foldexpr=ft#javascript#fold(v:lnum)
setlocal foldmethod=expr

let g:used_javascript_libs = 'jquery,lodash,underscore,react'


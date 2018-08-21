function! ft#php#FixParens()
    exe "%s:^\\(\\s\\+\\)\\(if\\|foreach\\|switch\\|while\\|for\\|try\\)\\(.\\{-}\\) {\\s*\\n\\(\\s*\\n\\)*:\\1\\2\\3\\r\\1{\\r:e"
    exe "%s:^\\(\\s\\+\\)} else {\\s*\\n\\(\\s*\\n\\)*:\\1}\\r\\1else\\r\\1{\\r:e"
    exe "%s:^\\(\\s\\+\\)} catch \\(.\\{-}\\) {\\s*\\n\\(\\s*\\n\\)*:\\1}\\r\\1catch \\2\\r\\1{\\r:e"
    exe "%s:^\\(\\s\\+\\)} elseif \\(.\\{-}\\) {\\s*\\n\\(\\s*\\n\\)*:\\1}\\r\\1elseif \\2\\r\\1{\\r:e"
    exe "%s:^\\(\\s\\+\\)\\(if\\|foreach\\|switch\\|while\\|for\\)(:\\1\\2 (:e"
    exe "%s:^\\(\\s\\+\\)\\(.\\{-}\\) function \\([^{]\\+\\){$:\\1\\2 function \\3\\r\\1{:e"
endf

function! ft#php#FixParensPsr2()
    exe "%s:\\v^(\\s+)(if|elseif|foreach|switch|while|for|try|catch)\\(:\\1\\2 (:e"
    exe "%s:\\v^(\\s+)(if|foreach|switch|while|for|try)(.{-})\\s*\\n\\s*\\{\\s*\\n:\\1\\2\\3 {\\r:e"
    exe "%s:\\v^(\\s+)}\\n\\s*else\\s*\\n\\s*\\{\\s*\\n:\\1} else {\\r:e"
    exe "%s:\\v^(\\s+)}\\n\\s*(catch|elseif|else if) (.{-})\\s*\\n\\s*\\{\\s*\\n:\\1} \\2 \\3 {\\r:e"
    " exe "%s:\\v^(\\s+)(.{-}) function([^{]+)\\s*\\n\\s*\\{\\s*$:\\1\\2 function\\3 {:e"
    exe "%s:\\v^(\\s+)((private|protected|public|final|static|abstract)\\s*) function ([^{]{-})\\s*\\{\\s*$:\\1\\2 function \\4\\r\\1{:e"
endf

function! ft#php#Phpcbf()
    let file = expand('%:p')
    let path = fnamemodify(file, ':h')
    while fnamemodify(path, ':t') != 'src'
        let path = fnamemodify(path, ':h')
        if fnamemodify(path, ':t') == ''
            echohl ErrorMsg | echo "ERROR: Not in nt-like project - can't find phpbcf script" | echohl None
            return
        endif
    endw
    let path = fnamemodify(path, ':h')
    let phpcbf = path . "\\vendor\\squizlabs\\php_codesniffer\\bin\\phpcbf -n --extensions=php --standard=" . path . "\\.psr2tabs.xml -p "
    let command = "php " . phpcbf . file
    try
        let result = system(command)
        exe "edit!"
    catch
        echoerr v:exception
    endtry
endf

function! ft#php#Fold(lnum)
    let linem1 = getline(a:lnum - 1)
    let line0 = getline(a:lnum)

    if line0 =~ '^\t{$' && linem1 =~# '\v^\t[^\t]{-}function .{-}[^{]$'
        return '>1'
    elseif line0 =~ '^\t}$'
        return '<1'
    else
        return '='
    endif
endfunction


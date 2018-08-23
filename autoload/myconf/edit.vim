function! myconf#edit#UnderscoreToCamelCase(s)
    let result = substitute(a:s, '\C\S\@<=_\([a-z]\)', '\u\1', 'ge')
    if (exists("b:underscore_to_camel_case_first_upper") && b:underscore_to_camel_case_first_upper == 1)
        return substitute(result, '\([a-z]\)', '\u\1', 'e')
    else
        return result
    endif
endf

function! myconf#edit#CamelCaseToUnderscore(s)
    let result = substitute(a:s, '\C\<\@!\([A-Z]\)', '\_\l\1', 'ge')
    return substitute(result, '\([A-Z]\)', '\l\1', 'e')
endf

function! myconf#edit#Retab() range abort
    let pat = '\v( {' . &ts . '})+'
    let repl = '\=repeat("\t", strlen(submatch(0)) / &ts)'
    silent! execute (a:firstline) . "," . a:lastline . 's:' . pat . ':' . repl . ':g'
endfunction

function! myconf#edit#Untab() range abort
    let pat = '\v(\t)+'
    let repl = '\=repeat(" ", strlen(submatch(0)) * &ts)'
    silent! execute (a:firstline) . "," . a:lastline . 's:' . pat . ':' . repl . ':g'
endfunction

function! myconf#edit#SmartBackspace()
    let pattern = join(['\V\s\@<=\.', '\_^\@<=\.', '\[\^;[=,({<>''`"./_$@!:#]\@<=\.', '\(->\)\@<=\.', '-\@<=\[^>]', '\(::\)\@<=\.', '\u\@<!\u'], '\|')
    return search(pattern, 'b')
endf


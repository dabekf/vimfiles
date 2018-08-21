" Old Tabs
" @deprecated
if exists("g:CtrlSpaceLoaded") && g:CtrlSpaceLoaded == 2
    function! GetTabNr(nr)
        let l:tablist = []
        for i in range(tabpagenr('$'))
            let l:buflist = tabpagebuflist(i + 1)
            if index(l:buflist, a:nr) != -1
                return (i + 1)
            endif
    "        call extend(tablist, tabpagebuflist(i + 1))
        endfor
    "    echo tablist
    endf

    map <silent> <A-t> :tabnew<CR>
    imap <silent> <A-t> <C-c>:tabnew<CR>

    function! CloneTab()
        exe "silent! normal mZ"
        exe "tabnew"
        exe "silent! normal g`Z"
    endf
    map <silent> <A-T> :call CloneTab()<CR>
    imap <silent> <A-T> <C-c>:call CloneTab()<CR>

    for index in [1, 2, 3, 4, 5, 6, 7, 8, 9]
        execute "map <A-".index."> :tabn ".index."<CR>"
        execute "imap <A-".index."> <Esc>:tabn ".index."<CR>"
    endfor

    map <silent> <A-<> :if tabpagenr() > 1 \| execute ":tabmove ".(tabpagenr()-2) \| endif<CR>
    imap <silent> <A-<> <Esc>:if tabpagenr() > 1 \| execute ":tabmove ".(tabpagenr()-2) \| endif<CR>
    map <silent> <A->> :execute ":tabmove ".tabpagenr()<CR>
    imap <silent> <A->> <Esc>:execute ":tabmove ".tabpagenr()<CR>

    map <silent> <A-,> :tabp<CR>
    imap <silent> <A-,> <C-c>:tabp<CR>
    map <silent> <A-.> :tabn<CR>
    imap <silent> <A-.> <C-c>:tabn<CR>
    map <silent> <C-PageUp> :tabp<CR>
    imap <silent> <C-PageUp> <C-c>:tabp<CR>
    map <silent> <C-PageDown> :tabn<CR>
    imap <silent> <C-PageDown> <C-c>:tabn<CR>

    function! ReloadTabs()
        let l:tabnr = tabpagenr()
        exe "e!"
        exe "tabn"
        while tabpagenr() != l:tabnr
            exe "e!"
            exe "tabn"
        endw
    endf
    map <A-E> :call ReloadTabs()<CR>
    map <A-e> :e<CR>

    " Close buffer
    function! CloseBuffer()
        if &buftype == ""
            bdelete!
        else
            close
        endif
    endf
    nmap <silent> <A-k> :call CloseBuffer()<CR>
    imap <silent> <A-k> <C-o>:call CloseBuffer()<CR>

    " Chdir
    nnoremap <A-p> :exe "lcd " . expand("%:p:h")<CR>
endif


" MyVim
let $myvimrc = $HOME . '/.vimrc'
let $myconf = fnamemodify($myvimrc, ':h') . '/.vim'

" These must be set before plugins
call myconf#options#SetGlobalOptions()
" call myconf#misc#StartProfiling()

" execute pathogen#infect()
silent! call plug#begin($myconf . '/plugged')
Plug 'ntpeters/vim-better-whitespace'
Plug 'vim-ctrlspace/vim-ctrlspace'
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
Plug 'alvan/vim-closetag'
Plug 'andymass/vim-matchup'
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'embear/vim-localvimrc'
Plug 'honza/vim-snippets'
Plug 'jnurmine/Zenburn'
Plug 'sainnhe/sonokai'
Plug 'kshenoy/vim-signature'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTree', 'NERDTreeFind', 'NERDTreeToggle'] }
Plug 'sgur/vim-editorconfig'
Plug 'skywind3000/asyncrun.vim'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-surround'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'junegunn/vim-easy-align'
call plug#end()

" Menu language to english
let $LANG = 'en'
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

set nocompatible

" Colors
if has('termguicolors')
    if &term == "screen.xterm-256color"
        set term=xterm-256color " Italics from sonokai don't work with screen.xterm-256color
    endif
    if &term == "xterm-256color"
        set termguicolors
    else
        set notermguicolors
    endif
endif

" Zenburn theme
let g:zenburn_high_Contrast = 1
let g:zenburn_old_Visual = 1
let g:zenburn_alternate_Visual = 1
let g:zenburn_unified_CursorColumn = 1
"colorscheme fixedzenburn

" Sonokai theme
let g:sonokai_style = 'shusia'
let g:sonokai_better_performance = 1
let g:sonokai_enable_italic = 1
let g:sonokai_colors_override = {'bg0': ['#1f1f1f', '234']}
augroup SonokaiCustom
    autocmd!
    autocmd ColorScheme sonokai call myconf#sonokai#CustomColors()
augroup END
colorscheme sonokai

" Settings
set autoindent
set autoread
set autowrite " Automatically save before commands like :next and :make
set background=dark
set backspace=indent,eol,start
set backupcopy=yes
set backupdir=~/.backup
set clipboard=unnamed
set completeopt=longest,menu
set directory=.,~/.backup
set encoding=utf-8
set expandtab
set fileformat=unix
set fileformats=unix,dos
" set fillchars=vert:│,fold:─
set formatoptions=qn12
set guifont="Output Mono NF:h11"
set guioptions=gcA
set hidden
set history=100
set hlsearch
set ignorecase " Do case insensitive matching
set incsearch " Incremental search
set indentexpr=
set keymodel=startsel
set langmenu=en
set laststatus=2
set listchars=eol:¬,precedes:«,extends:»,tab:⇒\ ,trail:›,nbsp:_
set mouse=a
set nobackup " Don't keep a backup file
set nocindent
set nomodeline
set showcmd
set showmode
set noundofile
set ruler
set selection=inclusive
set selectmode=mouse,key
set sessionoptions=blank,buffers,curdir,folds,tabpages,help
" set shell=powershell\ -NoLogo\ -NonInteractive
" set shellcmdflag=-Command
set shellslash
set shiftwidth=4
set showcmd " Show (partial) command in status line.
set showmatch " Show matching brackets.
set smartcase
set smartindent
set softtabstop=-1
set spelllang=en_gb,pl
set tabstop=4
set termguicolors
set textwidth=0
set tags=./.tags,.tags
set timeoutlen=1000
set undodir=~/.backup
set viminfo='2000,\"50000,h"
set virtualedit=block,onemore
set whichwrap=b,s,<,>
set wildignore=.git,.svn,.hg,CVS,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.swo,*.jpg,*.png,*.gif,*.zip,*.pdf,*.exe,*.pyc,tags,*.tags
set wildmode=full
set winaltkeys=no
set wrap " Add binding!

let mapleader = ","

" Quits and writes
noremap <Esc>q <C-c>:q!<CR>
noremap <Esc>Q <C-c>:qa!<CR>
noremap! <Esc>q <C-c>:q!<CR>
noremap! <Esc>Q <C-c>:qa!<CR>

noremap <Esc>w <C-c>:x!<CR>
noremap <Esc>W <C-c>:xa!<CR>
noremap! <Esc>w <C-c>:x!<CR>
noremap! <Esc>W <C-c>:xa!<CR>

nnoremap <Esc>s :update<CR>
nnoremap <Esc>S :wa<CR>
noremap! <Esc>s <C-o>:update<CR>
noremap! <Esc>S <C-o>:wa<CR>

nnoremap <F2> :update<CR>
nnoremap <S-F2> :wa<CR>
noremap! <F2> <C-o>:update<CR>
noremap! <S-F2> <C-o>:wa<CR>

nnoremap <F3> n
nnoremap <S-F3> N
noremap! <F3> <C-o>n
noremap! <S-F3> <C-o>N

" Block help
" nnoremap <silent> <F1> :<CR>
" noremap! <silent> <F1> <C-o>:<CR>

" nnoremap <Esc>g :echo expand('%:p:gs?\\?/?')<CR>
" nnoremap <Esc>G :echo fnamemodify(getcwd(), ':gs?\\?/?')<CR>
nnoremap <Esc>g :echo expand('%:p:g')<CR>
nnoremap <Esc>G :echo fnamemodify(getcwd(), ':g')<CR>

" For Midnight Commander
if has("unix")
    nnoremap <Esc>o <C-o>
    inoremap <Esc>o <C-o>
    vnoremap <Esc>o <C-o>
endif

" For screen and poor quality terminals
"if has("unix")
"    set <C-Home>=[1;5H
"    set <C-End>=[1;5F
"    set <S-F1>=[1;2P
"    set <S-F2>=[1;2Q
"    set <S-F3>=[1;2R
"    set <S-F4>=[1;2S
"    set <F15>=[1~
"    map <F15> <Home>
"    map! <F15> <Home>
"    set <F16>=[4~
"    map <F16> <End>
"    map! <F16> <End>
"    set <F13>=[1;3D
"    map <F13> <A-Left>
"    map! <F13> <A-Left>
"    set <F14>=[1;3C
"    map <F14> <A-Right>
"    map! <F14> <A-Right>
"    set t_Co=256
"endif

" File Explorer
function! s:ToggleNERDTree()
    let bufname = bufname("%")

    if bufname == ""
        exe "NERDTree"
    elseif &ft == 'nerdtree'
        exe "NERDTreeToggle"
    else
        exe "NERDTreeFind"
    endif
endf
let g:NERDTreeWinSize = 42
let g:NERDTreeDirArrowCollapsible = '↑'
let g:NERDTreeDirArrowExpandable = '↓'
let g:NERDTreeQuitOnOpen = 1
nnoremap <silent> <F4> :call <SID>ToggleNERDTree()<CR>
nnoremap <silent> <S-F4> :NERDTreeClose<CR>

" Rg
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading\ -e
    set grepformat=%f:%l:%c:%m,%f:%l:%m
    command! -nargs=* Rg :silent grep! <args> | cope
endif

" LeaderF
let g:Lf_DefaultMode = 'FullPath'
let g:Lf_HideHelp = 1
let g:Lf_IndexTimeLimit = 10
let g:Lf_NeedCacheTime = 0.5
" let g:Lf_RememberLastSearch = 1
" let g:Lf_ShowRelativePath = 0
let g:Lf_StlSeparator = { 'left': '→', 'right': '←' }
let g:Lf_WildIgnore = { 'dir': [], 'file': ['.*'] }
let g:Lf_WindowHeight = 15
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_StlPalette = {
\ 'stlName': { 'gui': 'NONE', 'guifg': '#baffa3', 'guibg': '#313633' },
\ 'stlCategory': { 'guifg': '#f28379', 'guibg': '#161616' },
\ 'stlNameOnlyMode': { 'guifg': '#e8ed51', 'guibg': '#313633' },
\ 'stlFullPathMode': { 'guifg': '#aaaaff', 'guibg': '#313633' },
\ 'stlFuzzyMode': { 'guifg': '#e8ed51', 'guibg': '#313633' },
\ 'stlRegexMode': { 'guifg': '#7fecad', 'guibg': '#313633' },
\ 'stlCwd': { 'guifg': '#ebffef', 'guibg': '#161616' },
\ 'stlBlank': { 'guifg': '#313633', 'guibg': '#313633' },
\ 'stlLineInfo': { 'guifg': '#ebffef', 'guibg': '#161616' },
\ 'stlTotal': { 'guifg': '#bcdc5c', 'guibg': '#313633' },
\}
let g:Lf_ShortcutF = '<C-p>'
let g:Lf_ShortcutB = '<C-b>'
nmap <silent> <C-h> :LeaderfMru<CR>
nmap <silent> <C-f> :<C-U>LeaderfFunction<CR>
nmap <silent> <C-g> :<C-U>LeaderfBufTag<CR>
nmap <silent> <Leader><C-p> :<C-U>Leaderf file --stayOpen<CR>

" Clear search highlight
nnoremap <Esc>h :noh<CR>

" Identify highlight group
nnoremap <Esc>H :redraw \| echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
    \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
    \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Redraw screen
nmap <silent> <C-l> :redraw<CR>:redraws<CR>

" Cursor cross
nmap <silent> <Esc># :setlocal cursorcolumn! cursorline!<CR>
imap <silent> <Esc># <C-o>:setlocal cursorcolumn! cursorline!<CR>

" <Leader>v brings up my .vimrc
nnoremap <silent> <Leader>v :e $myvimrc<CR>

" <Leader>f is fileformat
nnoremap <Leader>f :set fileformat=unix<CR>
nnoremap <Leader>F :set fileformat=dos<CR>

" <Leader>s is sort
xnoremap <Leader>s :sort<CR>
xnoremap <Leader>S :sort u<CR>

" Select whole word
nnoremap <Esc>v viW
inoremap <Esc>v <C-o>viW
vnoremap <Esc>v <C-c>viW

" A-d is delete line
nnoremap <Esc>d "_dd
inoremap <Esc>d <C-o>"_dd
vnoremap <Esc>d "_d
nnoremap <C-Del> "_dd
inoremap <C-Del> <C-o>"_dd
vnoremap <C-Del> "_d

" Ctrl-d is delete what I want
inoremap <silent> <C-d> <C-o>"_d:call myconf#edit#SmartBackspace()<CR>

" <Leader>n is find nonprintable characters
nnoremap <Leader>n /\(\p\\|$\\|\s\)\@!.<CR>

" Undo
if has("unix")
    nnoremap <C-z> u
    inoremap <C-z> <C-o>u
    vnoremap <C-z> <C-o>u
    nnoremap <C-y> <C-R>
    inoremap <C-y> <C-o><C-R>
    vnoremap <C-y> <C-o><C-R>
endif
nnoremap <Esc>u u
noremap! <Esc>u <C-o>u
nnoremap <Esc>r <C-R>
noremap! <Esc>r <C-o><C-R>

" Fix completion
inoremap <expr> <C-Y> pumvisible() ? "\<C-Y>" : "\<C-O>\<C-R>"

" Paste in Insert mode on the end of line
" Fix copied from paste.vim and ms.vim
let paste#paste_cmd = {'n': "\"=@+.'xy'<CR>gPFx\"_2x"}
let paste#paste_cmd['v'] = '"-c<Esc>gix<Esc>' . paste#paste_cmd['n'] . '"_x'
let paste#paste_cmd['i'] = 'x<Esc>' . paste#paste_cmd['n'] . '"_s'
exe 'inoremap <silent> <script> <C-V> <C-G>u' . paste#paste_cmd['i']
exe 'vnoremap <silent> <script> <C-V> ' . paste#paste_cmd['v']

" Paste mode
set pastetoggle=<F1>

" Paste with nopaste
noremap! <MiddleMouse> <C-o>:set paste<CR><MiddleMouse><C-o>:set nopaste<CR>

" Paste over
xnoremap p "_d:set paste<CR>p:set nopaste<CR>
xnoremap P "_d:set paste<CR>P:set nopaste<CR>

" Insert epoch
inoremap <silent> <Esc>t <C-r>=localtime()<CR>

" Syntax toggle
function! s:ToggleSyntax()
    if exists("g:syntax_on")
        syntax off
    else
        syntax enable
    endif
endf
nnoremap <S-F1> :call <SID>ToggleSyntax()<CR>
noremap! <S-F1> <C-o>::call <SID>ToggleSyntax()<CR>

" Win32 like
if has("unix")
    nnoremap <C-V> P
    inoremap <C-V> <C-o>P
    vnoremap <C-C> y
    vnoremap <C-X> d
endif

" Toggle matching parens
nnoremap <Esc>m :call myconf#misc#ToggleMatchParen()<CR>
noremap! <Esc>m <C-o>:call myconf#misc#ToggleMatchParen()<CR>
let g:matchup_matchparen_deferred = 1
let g:matchup_matchparen_status_offscreen = 0

" Commenting
nmap <Esc>c gcc
" nmap <Esc>C gcgc
xmap <Esc>c gc
smap <Esc>c <C-g>gc
imap <Esc>c <C-_><C-_>

" Folding
set foldmethod=manual
" nnoremap <silent> <Esc>f za[z<End>
" inoremap <silent> <Esc>f <C-O>za<C-O>[z<End>
nnoremap <silent> <Esc>f za
inoremap <silent> <Esc>f <C-O>za

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Closetag
let g:closetag_filenames = '*.xml,*.html,*.xhtml,*.phtml,*.php,*.js,*.jsx'
let g:closetag_xhtml_filenames = '*.xhtml,*.js,*.jsx'
let g:closetag_close_shortcut = '®'

" JSX
let g:jsx_ext_required = 0

" Indenting
xnoremap < <gv
xnoremap > >gv
smap < <C-o><
smap > <C-o>>
nnoremap <Leader>t :%call myconf#edit#Untab()<CR>
nnoremap <Leader>T :%call myconf#edit#Retab()<CR>

" Show nontext characters
nnoremap <Esc>l :setlocal list!<CR>
inoremap <Esc>l <C-O>:setlocal list!<CR>

" Fixing broken endings
nnoremap <Leader>m :%s:\%x0d::g<CR>

" Mercurial
if executable('hg')
    nnoremap ,' :AsyncRun! hg commit -A<CR>
    nnoremap ,[ :AsyncRun! hg pull --rebase<CR>
    nnoremap ,] :AsyncRun! hg push<CR>
    nnoremap ,; :AsyncRun! hg version<CR>:botright copen 8<CR>
endif

" Buffers
nnoremap <Space> zz

" Help
function! s:Help(topic)
    try
        exe "help" a:topic
        if &buftype == 'help'
            exe "silent! normal \<C-w>o"
        endif
    catch
        echoerr v:exception
    endtry
endf
command! -nargs=1 -complete=help H :call <SID>Help("<args>")
command! -bar Helptags :call pathogen#helptags()

" Windows
nmap <M-Down> <C-w><Down>
imap <M-Down> <C-o><C-w><Down>
nmap <M-Up> <C-w><Up>
imap <M-Up> <C-o><C-w><Up>
"imap <silent> <C-PageUp> <Esc>:tabprev<CR>
"imap <silent> <C-PageDown> <Esc>:tabnext<CR>

" Asyncrun
augroup QuickFixStatus
    autocmd!
    au! BufWinEnter quickfix
        \ setlocal statusline=%!myconf#statusline#QuickFixLine() |
        \ setlocal nobl
augroup END
function! AsyncRunExit()
    if g:asyncrun_status == 'failure'
        botright copen 10
    endif
endf
let g:asyncrun_exit = 'call AsyncRunExit()'

" BetterWhitespace
let g:better_whitespace_filetypes_blacklist = ['', 'diff', 'gitcommit', 'unite', 'qf', 'help', 'markdown']
let g:better_whitespace_enabled = 0
" let g:better_whitespace_verbosity = 1
" let g:current_line_whitespace_disabled_soft = 1
nmap <silent> <Leader>w :ToggleStripWhitespaceOnSave<CR>:echo 'Changed b:strip_whitespace_on_save to ' . b:strip_whitespace_on_save<CR>

" Localrc
let g:localvimrc_ask = 0

" Signature
nmap m<C-R> :SignatureRefresh<CR>

" Autocommand
autocmd! VimEnter
augroup myconf
    autocmd!

    function! s:ToggleFullscreen()
        if exists('g:loaded_fullscreen')
            " ToggleFullscreen
        endif
    endfunction
    autocmd VimEnter * call <SID>ToggleFullscreen()

    " When editing a file, always jump to the last cursor position
    autocmd BufWinEnter * call myconf#misc#JumpToLastPosition()
    autocmd BufReadPost * stopinsert

    " Misc
    autocmd FileChangedShell * echohl WarningMsg | echo "Warning: File changed on disk" | echohl None
    autocmd CursorHold,CursorHoldI * silent! checktime
    autocmd BufRead,BufNewFile *.conf setlocal filetype=conf

    " Better Whitespace
    function! s:EnableStripWhiteSpace()
        if exists("g:loaded_better_whitespace_plugin") && index(g:better_whitespace_filetypes_blacklist, &ft) < 0
            exec 'EnableStripWhitespaceOnSave'
        endif
    endfunction
    autocmd BufNewFile,BufRead * call <SID>EnableStripWhiteSpace()

    " Editorconfig trim whitespace bug
    function! ClearEditorConfigTrimHistory()
        while histget("search", -1) == "\\s\\+$"
            call histdel("search", -1)
        endwhile
        if @/ == "\\s\\+$"
            let @/ = histget("search", -1)
        endif
    endfunction
    autocmd BufWritePost * call ClearEditorConfigTrimHistory()

    " Update statusline upon entering command mode
    autocmd CmdlineEnter : redrawstatus
augroup END

filetype plugin on

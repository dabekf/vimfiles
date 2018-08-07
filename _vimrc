" MyVim
let $myvimrc = expand('<sfile>')
let $myconf = fnamemodify($myvimrc, ':h')

" First things first
let g:CtrlSpaceFileEngine = "file_engine_windows_386.exe"
let g:CtrlSpaceSearchTiming = 250
if executable("rg")
	let g:CtrlSpaceGlobCommand = 'rg %s -l --nocolor -g ""'
endif
if has("gui_running")
	let g:CtrlSpaceSymbols = { "WLoad": "↑", "WSave": "↓", "File": "◯", "CTab": "▣", "Tabs": "▢" }
endif

" execute pathogen#infect()
call plug#begin($myconf . '/plugged')
Plug 'w0rp/ale'
Plug 'skywind3000/asyncrun.vim'
Plug 'FelikZ/ctrlp-py-matcher'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'sgur/vim-editorconfig'
Plug 'othree/html5.vim', { 'for': ['html', 'php'] }
Plug 'cohama/lexima.vim'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTree', 'NERDTreeFind', 'NERDTreeToggle'] }
Plug 'StanAngeloff/php.vim', { 'for': ['php', 'phtml'] }
Plug 'shawncplus/phpcomplete.vim', { 'for': ['php', 'phtml'] }
Plug 'ervandew/supertab'
Plug 'majutsushi/tagbar'
Plug 'vim-php/tagbar-phpctags.vim', { 'for': ['php', 'phtml'] }
Plug 'tomtom/tcomment_vim'
Plug 'SirVer/ultisnips'
Plug 'filedil/vim-better-whitespace', { 'branch': 'search-history-fix' }
Plug 'alvan/vim-closetag'
Plug 'filedil/vim-ctrlspace', { 'branch': 'workspaces-fix' }
Plug 'filedil/vim-gitbranch', { 'branch': 'with-hgbranch' }
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'jsx'] }
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'mxw/vim-jsx', { 'for': 'jsx' }
Plug 'embear/vim-localvimrc'
Plug 'okcompute/vim-python-match', { 'for': 'python' }
Plug 'tpope/vim-scriptease'
Plug 'honza/vim-snippets'
Plug 'jnurmine/Zenburn'
call plug#end()

" menu language to english
let $LANG = 'en'
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

if hostname() == 'PAPAYA'
	au GUIEnter * simalt ~x
else
	au GUIEnter * simalt ~s
endif

set nocompatible

" Theme first
let g:zenburn_high_Contrast = 1
let g:zenburn_old_Visual = 1
let g:zenburn_alternate_Visual = 1
let g:zenburn_unified_CursorColumn = 1
colorscheme fixedzenburn

" Settings
set autoindent
set autoread
set autowrite " Automatically save before commands like :next and :make
set background=dark
set backspace=indent,eol,start
set backupcopy=yes
set backupdir=$TEMP,.
set clipboard=unnamed
set completeopt=longest,menu
set directory=.,$TEMP
set encoding=utf-8
set fileformat=unix
set fileformats=unix,dos
set formatoptions=qn12
" set guifont=Consolas:h12
set guifont=Fixed_9x15:h11
set guioptions=egcA
set hidden
set history=100
set hlsearch
set ignorecase " Do case insensitive matching
set incsearch " Incremental search
set indentexpr=
set keymodel=startsel
set langmenu=en
set laststatus=2
set listchars=eol:¬,precedes:«,extends:»,tab:▸·,trail:›,nbsp:_
set mouse=a
set nobackup " Don't keep a backup file
set nocindent
set noexpandtab
set nomodeline
set noshowmode
set noundofile
set ruler
set selection=inclusive
set selectmode=mouse,key
set sessionoptions=blank,buffers,curdir,folds,tabpages,help
" set shell=powershell\ -NoLogo\ -NonInteractive
" set shellcmdflag=-Command
set shellslash
set shiftwidth=0
set showcmd " Show (partial) command in status line.
set showmatch " Show matching brackets.
set smartcase
set smartindent
set softtabstop=0
set spelllang=en_gb,pl
set tabstop=4
set textwidth=0
set timeoutlen=1000
set undodir=$TEMP,.
set viminfo='2000,\"50000,h,n$APPDATA/_viminfo"
set virtualedit=block,onemore
set whichwrap=b,s,<,>
set wildignore=.git,.svn,.hg,CVS,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.swo,*.jpg,*.png,*.gif,*.zip,*.pdf,*.exe,*.pyc,tags,*.tags
set wildmode=longest:full
set winaltkeys=no
set wrap " Add binding!

let mapleader = ","

" Quits and writes
noremap <A-q> <C-c>:q!<CR>
noremap <A-Q> <C-c>:qa!<CR>
noremap! <A-q> <C-c>:q!<CR>
noremap! <A-Q> <C-c>:qa!<CR>

noremap <A-w> <C-c>:x!<CR>
noremap <A-W> <C-c>:xa!<CR>
noremap! <A-w> <C-c>:x!<CR>
noremap! <A-W> <C-c>:xa!<CR>

nnoremap <F2> :w<CR>
nnoremap <S-F2> :wa<CR>
noremap! <F2> <C-o>:w<CR>
noremap! <S-F2> <C-o>:wa<CR>

" nnoremap <A-g> :echo expand('%:p:gs?\\?/?')<CR>
" nnoremap <A-G> :echo fnamemodify(getcwd(), ':gs?\\?/?')<CR>
nnoremap <A-g> :echo expand('%:p:g')<CR>
nnoremap <A-G> :echo fnamemodify(getcwd(), ':g')<CR>

" For Midnight Commander
if has("unix")
	nnoremap <A-o> <C-o>
	inoremap <A-o> <C-o>
	vnoremap <A-o> <C-o>
endif

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
let g:NERDTreeWinSize=42
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeDirArrowExpandable = '▸'
nnoremap <silent> <F4> :call <SID>ToggleNERDTree()<CR>
nnoremap <silent> <S-F4> :NERDTreeClose<CR>

" CtrlP + rg
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading\ -e
    set grepformat=%f:%l:%c:%m,%f:%l:%m
	let g:ctrlp_user_command = 'rg %s --files --color=never -g ""'
endif
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
" let g:ctrlp_use_caching = 0
let g:ctrlp_lazy_update = 1
let g:ctrlp_clear_cache_on_exit = 1
nnoremap <silent> <C-b> :CtrlPBuffer<CR>
nnoremap <silent> <C-h> :CtrlPMRU<CR>
command! -nargs=* Rg :silent grep! <args> | cw

" Clear search highlight
nnoremap <A-h> :noh<CR>

" Identify highlight group
nnoremap <A-H> :redraw \| echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
	\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
	\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Cursor cross
nmap <silent> <A-#> :setlocal cursorcolumn! cursorline!<CR>
imap <silent> <A-#> <C-o>:setlocal cursorcolumn! cursorline!<CR>

" <Leader>v brings up my .vimrc
" <Leader>V reloads it -- making all changes active (have to save first)
nnoremap <silent> <Leader>v :e $myvimrc<CR>:cd $myconf<CR>

" <Leader>f is fileformat
nnoremap <Leader>f :set fileformat=unix<CR>
nnoremap <Leader>F :set fileformat=dos<CR>

" <Leader>s is sort
xnoremap <Leader>s :sort<CR>
xnoremap <Leader>S :sort u<CR>

" Select whole word
nnoremap <A-v> viW
inoremap <A-v> <C-o>viW
vnoremap <A-v> <C-c>viW

" A-d is delete line
nnoremap <A-d> "_dd
inoremap <A-d> <C-o>"_dd
vnoremap <A-d> "_d
nnoremap <C-Del> "_dd
inoremap <C-Del> <C-o>"_dd
vnoremap <C-Del> "_d

" <Leader>n is find nonprintable characters
nnoremap <Leader>n /\(\p\\|$\\|\s\)\@!.<CR>

" Undo
if has("unix")
	nnoremap <C-Z> u
	inoremap <C-Z> <C-o>u
	nnoremap <C-Y> <C-R>
	inoremap <C-Y> <C-o><C-R>
endif
nnoremap <A-u> u
noremap! <A-u> <C-o>u
nnoremap <A-r> <C-R>
noremap! <A-r> <C-o><C-R>

" Fix completion
inoremap <expr> <C-Y> pumvisible() ? "\<C-Y>" : "\<C-O>\<C-R>"
let g:lexima_no_default_rules = 1

" Paste in Insert mode on the end of line
" Fix copied from paste.vim and ms.vim
let paste#paste_cmd = {'n': "\"=@+.'xy'<CR>gPFx\"_2x"}
let paste#paste_cmd['v'] = '"-c<Esc>gix<Esc>' . paste#paste_cmd['n'] . '"_x'
let paste#paste_cmd['i'] = 'x<Esc>' . paste#paste_cmd['n'] . '"_s'
exe 'inoremap <silent> <script> <C-V> <C-G>u' . paste#paste_cmd['i']
exe 'vnoremap <silent> <script> <C-V> ' . paste#paste_cmd['v']

" Paste mode
nnoremap <silent> <F1> :set paste!<CR>
noremap! <silent> <F1> <C-o>:set paste!<CR>
set pastetoggle=<F1>

" Paste with nopaste
noremap! <MiddleMouse> <C-o>:set paste<CR><MiddleMouse><C-o>:set nopaste<CR>

" Paste over
xnoremap p "_d:set paste<CR>p:set nopaste<CR>
xnoremap P "_d:set paste<CR>P:set nopaste<CR>

" Insert epoch
inoremap <silent> <A-t> <C-r>=localtime()<CR>

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

" Better selection controls
if has("win32")
	snoremap <C-c> <C-o>"+y
	snoremap <C-x> <C-o>"+d
	snoremap <Up> <C-c><Up>
	snoremap <Down> <C-c><Down>
	snoremap <Left> <C-c><Left>
	snoremap <Right> <C-c><Right>
	snoremap <PageUp> <C-c><PageUp>
	snoremap <PageDown> <C-c><PageDown>
endif

" Toggle matching parens
nnoremap <A-m> :call myconf#func#ToggleMatchParen()<CR>
noremap! <A-m> <C-o>:call myconf#func#ToggleMatchParen()<CR>
" let loaded_matchparen = 1

" Commenting
nmap <A-c> gccj
" nmap <A-C> gcgc
xmap <A-c> gc
smap <A-c> <C-g>gc
imap <A-c> <C-_><C-_><C-o>j

" Folding
set foldmethod=manual
nnoremap <silent> <A-f> za[z<End>
inoremap <silent> <A-f> <C-O>za<C-O>[z<End>

" Taglist
if executable('ctags')
	nnoremap <silent> <F5> :TagbarOpenAutoClose<CR>
	nnoremap <silent> <S-F5> :TagbarToggle<CR>
	let g:tagbar_autoclose = 0
endif

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

" Fixing indentation
nnoremap <silent> <Leader>t :%s@^\(    \)\+@\=repeat('	', strlen(submatch(0))/4)@g<CR>:noh<CR>
nnoremap <silent> <Leader><A-t> :%s@^\(  \)\+@\=repeat('	', strlen(submatch(0))/2)@g<CR>:noh<CR>
vnoremap <silent> <Leader>t :s@^\(    \)\+@\=repeat('	', strlen(submatch(0))/4)@g<CR>:noh<CR>
vnoremap <silent> <Leader><A-t> :s@^\(  \)\+@\=repeat('	', strlen(submatch(0))/2)@g<CR>:noh<CR>

nnoremap <silent> <Leader>y :%s@^\(	\)\+@\=repeat(' ', strlen(submatch(0))*&ts)@g<CR>:noh<CR>
vnoremap <silent> <Leader>y :s@^\(	\)\+@\=repeat(' ', strlen(submatch(0))*&ts)@g<CR>:noh<CR>

nnoremap <silent> <Leader>T :%s@^\s\+$@@g<CR>:noh<CR>
vnoremap <silent> <Leader>T :s@^\s\+$@@g<CR>:noh<CR>

nnoremap <A-l> :set list!<CR>
inoremap <A-l> <C-O>:set list!<CR>

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
imap <silent> <C-PageUp> <Esc>:tabprev<CR>
imap <silent> <C-PageDown> <Esc>:tabnext<CR>

" Asyncrun
augroup QuickfixStatus
    au! BufWinEnter quickfix
		\ setlocal statusline=%t\ [%{g:asyncrun_status}]\ %{exists('w:quickfix_title')?\ '\ '.w:quickfix_title\ :\ ''}\ %=%-15(%l,%c%V%)\ %P |
		\ setlocal nobl
augroup END
function! AsyncRunExit()
	if g:asyncrun_status == 'failure'
		botright copen 10
	endif
endf
let g:asyncrun_exit = 'call AsyncRunExit()'

" Ale (linting)
let g:ale_sign_error = '»»'
let g:ale_sign_style_error = "S»"
" let g:ale_sign_warning = '┄┄'
let g:ale_sign_warning = '▪▪'
let g:ale_sign_style_warning = 'S┄'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
" let g:ale_sign_column_always = 1
" let g:ale_change_sign_column_color = 1
" let g:ale_warn_about_trailing_whitespace = 0
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_javascript_eslint_executable = 'eslint_d'
let g:ale_python_flake8_executable = 'python'
let g:ale_python_flake8_options = '-m flake8 --select F,E999'
highlight ALEErrorSign guifg=#cc9393 guibg=#181818
let g:ale_linters = {
\	'python': ['flake8'],
\}
let g:ale_fixers = {
\   'javascript': ['eslint'],
\}
nmap <silent> <F3> <Plug>(ale_lint)
nmap <silent> <S-F3> <Plug>(ale_fix)
nmap <silent> <A-n> <Plug>(ale_next_wrap)zv
nmap <silent> <A-p> <BS><Plug>(ale_previous_wrap)zv

" BetterWhitespace
let g:better_whitespace_filetypes_blacklist = ['', 'diff', 'gitcommit', 'unite', 'qf', 'help', 'markdown']
let g:better_whitespace_enabled = 0
" let g:better_whitespace_verbosity = 1
" let g:current_line_whitespace_disabled_soft = 1
nmap <silent> <Leader>w :ToggleStripWhitespaceOnSave<CR>:echo 'Changed b:strip_whitespace_on_save to ' . b:strip_whitespace_on_save<CR>

" Localrc
let g:localvimrc_ask = 0

" Autocommand
augroup myconf
	autocmd!
	" Mail has width 75
	autocmd FileType mail set tw=75

	" When editing a file, always jump to the last cursor position
	autocmd BufWinEnter * call myconf#func#JumpToLastPosition()
	autocmd BufReadPost * stopinsert

	" When editing a crontab file, set backupcopy to yes rather than auto. See :help crontab and bug 53437.
	autocmd FileType crontab setlocal backupcopy=yes

	" phtml templates
	autocmd BufNewFile,BufRead *.phtml setlocal filetype=phtml
	autocmd BufNewFile,BufRead *.css.phtml setlocal filetype=css
	autocmd BufNewFile,BufRead .htaccess.* setlocal filetype=apache

	" csv wrapping
	autocmd BufNewFile,BufRead *.csv setlocal nowrap

	" Indenting
	autocmd BufNewFile,BufRead *.php,*.phtml,*.js,*.jsx,*.json setlocal indentexpr= smartindent autoindent nocindent
	autocmd BufNewFile,BufRead *.php setlocal nobomb
	autocmd BufNewFile,BufRead *.html,*.phtml,*.js,*.jsx,*.json,*.css setlocal tabstop=2
	autocmd BufNewFile,BufRead *.py setlocal noexpandtab shiftwidth=0 softtabstop=0 tabstop=4
	autocmd FileType python setlocal nosmartindent

	" Misc
	autocmd FileChangedShell * echohl WarningMsg | echo "Warning: File changed on disk" | echohl None
	autocmd CursorHold,CursorHoldI * silent! checktime

	function! s:FixHtmlItalics()
		hi htmlItalic gui=undercurl
		hi htmlBoldItalic gui=bold,undercurl
		hi htmlBoldUnderlineItalic gui=bold,underline,undercurl
		hi htmlUnderlineItalic gui=underline,undercurl
	endf

	" Fix italics
	if has("gui")
		autocmd BufNewFile,BufRead *.htm,*.html,*.phtml call <SID>FixHtmlItalics()
	endif

	function! s:InitLexima()
		if exists('g:loaded_lexima')
			call lexima#set_default_rules()
			call lexima#insmode#map_hook('before', '<CR>', '')

			call lexima#add_rule({'char': '(', 'at': '\%#\S'})
			call lexima#add_rule({'char': '[', 'at': '\%#\S'})
			call lexima#add_rule({'char': '{', 'at': '\%#\S'})
			" call lexima#add_rule({'char': "'", 'at': '\%#\S'})
			call lexima#add_rule({'char': "'", 'at': '\%#''', 'input': '<Right>', 'priority': 1})
			" call lexima#add_rule({'char': '"', 'at': '\%#\S'})
			call lexima#add_rule({'char': '"', 'at': '\w\%#"\@!'})
			call lexima#add_rule({'char': '"', 'at': '\%#"', 'input': '<Right>', 'priority': 1})

			inoremap <M-'> '
			inoremap <M-"> "
		endif
	endfunction
	autocmd VimEnter * call <SID>InitLexima()

	" Better Whitespace
	function! s:EnableStripWhiteSpace()
		if exists("g:loaded_better_whitespace_plugin") && index(g:better_whitespace_filetypes_blacklist, &ft) < 0
			exec 'EnableStripWhitespaceOnSave'
		endif
	endfunction
	autocmd BufNewFile,BufRead * call <SID>EnableStripWhiteSpace()
augroup END

filetype plugin on


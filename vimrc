" Startup
if has('vim_starting')
    if &compatible
        set nocompatible
    endif
endif
filetype off

" Vundle
if has('win32')
    set runtimepath+=~/vimfiles/bundle/vundle.vim
    call vundle#begin(expand('~/vimfiles/bundle/'))
else
    set runtimepath+=~/.vim/bundle/Vundle.vim
    call vundle#begin(expand('~/.vim/bundle/'))
endif

Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-fugitive'

Plugin 'drmikehenry/vim-headerguard'

Plugin 'tpope/vim-surround'

Plugin 'Raimondi/delimitMate'
let g:delimitMate_expand_cr = 1

Plugin 'rust-lang/rust.vim'

Plugin 'elzr/vim-json'

Plugin 'tpope/vim-vinegar'

Plugin 'tpope/vim-dispatch'

Plugin 'majutsushi/tagbar'

Plugin 'sjl/gundo.vim'

Plugin 'jelera/vim-javascript-syntax'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'scrooloose/syntastic'
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_c_checkers = ['cppcheck']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

call vundle#end()

" Filetype detection
syntax on
filetype plugin indent on

" Graphical settings
set ruler
set guioptions-=T
set guioptions-=m
set number
set formatoptions-=cro

if has("gui_running")
    set guifont=DejaVu_Sans_Mono:h10:cANSI
    set lines=50
    set columns=200
    colorscheme evening
else
    colorscheme desert
endif

" Platform specifics
if has('win32')
    set directory=$HOME/vimfiles/swap
    set bdir=$HOME/vimfiles/backup
    set viewdir=$HOME/vimfiles/view
    set undodir=$HOME/vimfiles/undo
    set makeprg=build.bat
else
    set directory=$HOME/.vim/swap
    set bdir=$HOME/.vim/backup
    set viewdir=$HOME/.vim/view
    set undodir=$HOME/.vim/undo
    set makeprg=./build.sh
endif

set grepprg=grep\ -n

" Undo
set undofile
set undolevels=1000
set undoreload=10000

" Miscellaneous
set autowrite
set autoread

set fileformats=unix,dos
set wildmode=list:longest,full
set infercase

set noshowmode

set updatecount=10

set nowrap
set incsearch
set backspace=indent,eol,start
set hidden

if !&scrolloff
    set scrolloff=5
endif
if !&sidescrolloff
    set sidescrolloff=5
endif
set display+=lastline,uhex
set autoindent
set smartindent
set copyindent
set shiftround
set smarttab

set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
if has("multi_byte")
    if &termencoding == ""
        let &termencoding = &encoding
    endif
    set encoding=utf-8
    setglobal fileencoding=utf-8
    set fileencodings=ucs-bom,utf-8,latin1
endif

if &encoding ==# 'latin1' && has('gui_running')
    set encoding=utf-8
endif

if &history < 1000
    set history=1000
endif

" Tabs
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Mappings
let mapleader=","

vmap Q gq
nmap Q gqap

nnoremap <silent> <Leader>cd :cd %:p:h<cr>
nnoremap <silent> <Leader>u :GundoToggle<cr>

" Special Files
nnoremap <Leader>ev :next $MYVIMRC<cr>
nnoremap <Leader>sv :source $MYVIMRC<cr>

" Fugitive
augroup ft_fugitive
    autocmd!

    autocmd BufNewFile,BufRead .git/index setlocal nolist
augroup END

" Splits
command! -nargs=? -complete=file El :lefta :vnew <args>
command! -nargs=? -complete=file Ed :bel :new <args>
command! -nargs=? -complete=file Eu :abo :new <args>
command! -nargs=? -complete=file Er :rightb :vnew <args>

command! -nargs=? -complete=buffer Bl :lefta :vert :sb <args>
command! -nargs=? -complete=buffer Bd :bel :sb <args>
command! -nargs=? -complete=buffer Bu :abo :sb <args>
command! -nargs=? -complete=buffer Br :rightb :vert :sb <args>

nnoremap <Leader>H :lefta :vnew<cr>
nnoremap <Leader>J :bel :new<cr>
nnoremap <Leader>K :abo :new<cr>
nnoremap <Leader>L :rightb :vnew<cr>

nnoremap <Leader>h <C-W><Left>
nnoremap <Leader>j <C-W><Down>
nnoremap <Leader>k <C-W><Up>
nnoremap <Leader>l <C-W><Right>

set wmh=0
nnoremap <Leader>m <C-W>=
nnoremap <Leader>M <C-W>_

" Keyword search
vnoremap <silent> <Leader>s y/<C-R>"<cr>
vnoremap <silent> <Leader>S y:%s/<C-R>"//n<cr>

" Quickfix and location windows
nnoremap <silent> ]n :cn<cr>
nnoremap <silent> [n :cp<cr>
nnoremap <silent> ]l :lne<cr>
nnoremap <silent> [l :lp<cr>

" Function Key definitions
nnoremap <silent> <F2> :w<cr>
inoremap <silent> <F2> <esc>:w<cr>i

nnoremap <silent> <F5> :bufdo :checktime<cr>
nnoremap <silent> <C-F5> :e<cr>G
nnoremap <silent> <F7> :set hls!<cr>
nnoremap <silent> <F8> :set nu!<cr>

nnoremap <silent> <F11> :TagbarToggle<cr>

" Autocommands
function! Eatchar(pat)
    let c = nr2char(getchar(0))
    return (c =~ a:pat) ? '' : c
endfunction

" Filetype: C,CPP
augroup filetype_c
    autocmd!
    autocmd FileType c,cpp let g:headerguard_newline=1
    autocmd FileType c,cpp setlocal cinoptions="(0,=0"

    autocmd FileType c,cpp nnoremap <buffer> <silent> <Leader>g :HeaderguardAdd<cr>
    autocmd FileType c,cpp nnoremap <buffer> <silent> <Leader>c Iclass <Esc>o{<cr>};<Esc>ko
    autocmd FileType cpp setlocal tags+=~/vimfiles/tags/msvc

    autocmd FileType cpp let OmniCpp_NamespaceSearch = 1
    autocmd FileType cpp let OmniCpp_GlobalScopeSearch = 1
    autocmd FileType cpp let OmniCpp_ShowAccess = 1
    autocmd FileType cpp let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
    autocmd FileType cpp let OmniCpp_MayCompleteDot = 1 " autocomplete after .
    autocmd FileType cpp let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
    autocmd FileType cpp let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
    autocmd FileType cpp let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
    " automatically open and close the popup menu / preview window
    autocmd CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
    autocmd FileType cpp set completeopt=menuone,menu,longest,preview

    autocmd FileType c noremap <buffer> <silent> <F4> :e %:p:s,.h$,.X123X,:s,.c$,.h,:s,.X123X$,.c,<cr>
    autocmd FileType c noremap <buffer> <silent> <F6> :!ctags -R --sort=yes --c-kinds=+pl --fields=+iaS --extra=+q .<cr>

    autocmd FileType cpp noremap <buffer> <silent> <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<cr>
    autocmd FileType cpp noremap <buffer> <silent> <F6> :!ctags -R --sort=yes --c++-kinds=+pl --fields=+iaS --extra=+q .<cr>

    autocmd FileType c,cpp noremap <buffer> <silent> <F12> <C-]>
augroup END

" FileType: Javascript
augroup filetype_javascript
    autocmd!
    autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
    autocmd FileType javascript setlocal equalprg=python\ c:\\Python27\\Scripts\\js-beautify\ --indent-size=2\ -X\ --stdin
augroup END

" Filetype: RC
augroup filetype_rc
    autocmd!
    autocmd FileType rc setlocal textwidth=0 noautoindent
augroup END

" Filetype: VIM
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal formatoptions-=cro
augroup END

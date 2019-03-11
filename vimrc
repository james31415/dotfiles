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

" Package manager
Plugin 'VundleVim/Vundle.vim'

" Theme
Plugin 'romainl/flattened'

Plugin 'tpope/vim-surround'

" Netrw enhancement
Plugin 'tpope/vim-vinegar'

" Typescript
Plugin 'leafgarland/typescript-vim'

call vundle#end()

" Filetype detection
filetype plugin indent on
syntax on

" Graphical settings
set ruler
set guioptions-=T
set guioptions-=m
set number
set relativenumber
set formatoptions-=cro

if has("gui_running")
    if has('win32')
        set guifont=DejaVu_Sans_Mono:h10:cANSI
    else
        set guifont=DejaVu\ Sans\ Mono\ 10
    endif

    colorscheme flattened_light
endif

set autoread

set noswapfile
set nobackup
set nowritebackup

" Platform specifics
if has('win32')
    set makeprg=build.bat
else
    set makeprg=./build.sh
endif

set grepprg=rg\ --vimgrep

" Miscellaneous
set fileformats=unix,dos
set wildmode=list:longest,full

set noshowmode

set nowrap
set incsearch
set hidden

if !&scrolloff
    set scrolloff=5
endif
if !&sidescrolloff
    set sidescrolloff=5
endif
set display+=lastline,uhex
set shiftround

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
" Copy previous indent
set autoindent

" Backspace behavior
set backspace=indent,eol,start

" Permits deletion of 4 space tabs as a single unit
set smarttab

set tabstop=2
set shiftwidth=2

" Mapping defined below

" Mappings
let mapleader=","

vmap Q gq
nmap Q gqap

nnoremap <silent> <Leader>cd :cd %:p:h<cr>

" Special Files
nnoremap <Leader>ev :next $MYVIMRC<cr>
nnoremap <Leader>sv :source $MYVIMRC<cr>

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


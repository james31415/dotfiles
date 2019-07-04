" Startup
if has('vim_starting')
	if &compatible
		set nocompatible
	endif
endif

filetype off
syntax off
set nohlsearch
nnoremap / /\v
set t_Co=0

" Graphical settings
set ruler
set guioptions-=T
set guioptions-=m

if has("gui_running")
	if has('win32')
		set guifont=DejaVu_Sans_Mono:h10:cANSI
	else
		set guifont=DejaVu\ Sans\ Mono\ 10
	endif
endif

set autoread
set noswapfile
set nobackup

set number

" Platform specifics
if has('win32')
	set makeprg=build.bat

	set errorformat+=%f(%l\\,%c):\ error\ %t%n:\ %m
	set errorformat+=%f(%l\\,%c):\ warning\ %t%n:\ %m
else
	set makeprg=./build.sh
endif

set grepprg=rg\ --vimgrep

set path=.,**
set wildmenu
set wildmode=list:longest,full

set wildignore+=**/node_modules/**
set wildignore+=**/.git/**

set wildignore+=*.o
set wildignore+=*.a

set noshowmode

set nowrap

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

" Tabs
" Copy previous indent
set autoindent

" Backspace behavior
set backspace=indent,eol,start

set tabstop=2
set shiftwidth=2

let g:netrw_banner=0
let g:netrw_hide=1

let s:dotfiles = '\(^\|\s\s\)\zs\.\S\+'
let s:escape = 'substitute(escape(v:val, ".$~"), "*", ".*", "g")'
let g:netrw_list_hide=
	\ join(map(split(&wildignore, ','), '"^".' . s:escape . '. "/\\=$"'), ',') .
	\ ',^\.\.\=/\=$' .
	\ (get(g:, 'netrw_list_hide', '')[-strlen(s:dotfiles)-1:-1] ==# s:dotfiles ? ','.s:dotfiles : '')


" Mapping defined below
" Mappings
let mapleader=","

inoremap <c-u> <esc>mzgUiw`za

nnoremap <Leader>o :only<cr>

nnoremap <Leader>p :pu +<cr>
nnoremap <Leader>y mz$viW"+y`z
nnoremap <silent> <Leader>cd :cd %:p:h<cr>
nnoremap <Leader>el :e <c-r>=expand("%:p:h")<cr>\

" Special Files
nnoremap <Leader>eb :vsplit $HOME/docs/bookmarks.txt<cr>
nnoremap <Leader>en :vsplit $HOME/docs/notes.txt<cr>
nnoremap <Leader>ep :vsplit $HOME/docs/projects.txt<cr>

nnoremap <Leader>ev :vsplit $MYVIMRC<cr>
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

" Quickfix and location windows
nnoremap <silent> ]n :cn<cr>
nnoremap <silent> [n :cp<cr>
nnoremap <silent> ]l :lne<cr>
nnoremap <silent> [l :lp<cr>

" Function keys
nnoremap <silent> <F5> :e<cr>
nnoremap <silent> <C-F5> :e<cr>G

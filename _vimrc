" Enables pathogen plugin {{{
call pathogen#infect()
"}}}

let mapleader=","

" Options {{{
" Graphical settings {{{
colorscheme evening
set guifont=DejaVu_Sans_Mono:h10:cANSI
set statusline=%<[%n]\ %f\ %y%h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
set guioptions-=T
set guioptions-=m
set number
hi StatusLine ctermfg=Yellow ctermbg=Blue
hi ColorColumn ctermbg=DarkRed guibg=DarkRed
call matchadd("ColorColumn", '\%81v', 100)

if has("gui_running")
  " GUI is running or is about to start.
  " Maximize gvim window (for an alternative on Windows, see simalt below).
  set lines=50 columns=100
else
  " This is console Vim.
  if exists("+lines")
    set lines=50
  endif
  if exists("+columns")
    set columns=100
  endif
endif
"}}}

" Filetype detection {{{
syntax on
filetype on
filetype plugin indent on
"}}}

" Directories {{{
set directory=$HOME/vimfiles/swap
set bdir=$HOME/vimfiles/backup
set viewdir=$HOME/vimfiles/view
set grepprg=grep\ -n
"}}}

" Miscellaneous {{{
set nowrap
set incsearch
set laststatus=2
set backspace=2
set confirm
set wildmenu
set hidden

if !&scrolloff
    set scrolloff=5
endif
if !&sidescrolloff
    set sidescrolloff=5
endif
set display+=lastline,uhex
set textwidth=80
set autoindent
if &encoding ==# 'latin1' && has('gui_running')
    set encoding=utf-8
endif

if &history < 1000
    set history=1000
endif
"}}}

" Tabs {{{
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
"}}}

" Mappings {{{
nnoremap <silent> <Leader>cd :cd %:p:h<cr>
nnoremap <space> @@
inoremap jk <Esc>

" Special Files {{{
nnoremap <Leader>ev :e $MYVIMRC<cr>
nnoremap <silent> gf :e <cfile><cr>
"}}}

" Fugitive {{{
augroup ft_fugitive
    autocmd!

    autocmd BufNewFile,BufRead .git/index setlocal nolist
augroup END
"}}}

" Splits {{{
nnoremap <Leader>H :lefta :vnew<cr>
nnoremap <Leader>K :abo :new<cr>
nnoremap <Leader>L :rightb :vnew<cr>
nnoremap <Leader>J :bel :new<cr>

nnoremap <Leader>h <C-W><Left>
nnoremap <Leader>j <C-W><Down>
nnoremap <Leader>k <C-W><Up>
nnoremap <Leader>l <C-W><Right>

set wmh=0
nnoremap <Leader>m <C-W>=
nnoremap <Leader>M <C-W>_
"}}}

" Buffer navigation {{{
nnoremap <Tab> :bn<cr>
nnoremap <S-Tab> :bp<cr>

vnoremap <silent> <Leader>s y/<C-R>"<cr>
vnoremap <silent> <Leader>S y:%s/<C-R>"//n<cr>
"}}}

" Function Key definitions {{{
nnoremap <silent> <C-F2> :if &guioptions =~# 'T' <Bar>
                         \set guioptions-=T <Bar>
                         \set guioptions-=m <Bar>
                    \else <Bar>
                         \set guioptions+=T <Bar>
                         \set guioptions+=m <Bar>
                    \endif<cr>
nnoremap <silent> <F4> :UB<cr>
nnoremap <silent> <F5> :e<cr>
nnoremap <silent> <C-F5> :e<cr>G
nnoremap <silent> <F6> :TlistToggle<cr>
nnoremap <silent> <F7> :set hls!<cr>
nnoremap <silent> <F8> :set nu!<cr>
nnoremap <silent> <F12> :e #<cr>
"}}}
"}}}

" Autocommands {{{
function! Eatchar(pat)
    let c = nr2char(getchar(0))
    return (c =~ a:pat) ? '' : c
endfunction

" Filetype: C,CPP {{{
augroup filetype_c
    autocmd!
    autocmd FileType c,cpp let g:headerguard_newline=1
    autocmd FileType c,cpp nnoremap <buffer> <silent> <Leader>g :HeaderguardAdd<cr>
    autocmd FileType c,cpp nnoremap <buffer> <silent> <Leader>c Iclass <Esc>o{<cr>};<Esc>ko
    autocmd FileType c,cpp inoremap <buffer> <silent> <C-B> <cr>{<cr>}<cr><Esc>kO
    autocmd FileType c,cpp nnoremap <buffer> <silent> <Leader>es :exe "e " . expand("%:r") . ".cpp"<cr>
    autocmd FileType c,cpp nnoremap <buffer> <silent> <Leader>eh :exe "e " . expand("%:r") . ".h"<cr>
augroup END
"}}}

" Filetype: Python {{{
augroup filetype_python
    autocmd!
    autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
    autocmd FileType python iabbrev <buffer> iff if:<left>
    autocmd FileType python iabbrev <buffer> eli elif:<left>
    autocmd FileType python iabbrev <buffer> imp import
    autocmd FileType python iabbrev <buffer> ret return()<left><c-r>=Eatchar('\s')<cr>
augroup END
"}}}

" Filetype: VIM {{{
augroup filetype_vim
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
    autocmd FileType vim setlocal tabstop=4 shiftwidth=4 expandtab
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType vim let b:surround_34 = "\"{{{ \r \"}}}"
augroup END
"}}}
"}}}

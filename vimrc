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

Plugin 'jremmen/vim-ripgrep'

Plugin 'scrooloose/syntastic'
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_c_checkers = ['cppcheck']
let g:syntastic_cpp_checkers = ['cppcheck']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

call vundle#end()

" Filetype detection
filetype plugin indent on
syntax on

" Graphical settings
set ruler
set guioptions-=T
set guioptions-=m
set number
set formatoptions-=cro

if has("gui_running")
    if has('win32')
        set guifont=DejaVu_Sans_Mono:h10:cANSI
    else
        set guifont=DejaVu\ Sans\ Mono\ 10
    endif

    colorscheme flattened_dark
endif

set noswapfile
set nobackup
set nowritebackup

" Platform specifics
if has('win32')
    set makeprg=build.bat
else
    set makeprg=./build.sh
endif

set grepprg=grep\ -n

" Miscellaneous
set fileformats=unix,dos
set wildmode=list:longest,full

set noshowmode

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

" Use spaces instead of tabs
set expandtab

" Number of spaces for tabs
set tabstop=4
set shiftwidth=4

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

" Function Key definitions
nnoremap <silent> <C-F5> :e<cr>G
nnoremap <silent> <F7> :set hls!<cr>
nnoremap <silent> <F8> :set nu!<cr>

function! s:ExecuteInShell(command)
    let command = join(map(split(a:command), 'expand(v:val)'))
    let winnr = bufwinnr('^' . command . '$')
    silent! execute winnr < 0 ? 'botright new ' . fnameescape(command) : winnr . 'wincmd w'
    setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number
    echo 'Execute ' . command . '...'
    silent! execute 'silent %!' . command
    silent! execute 'resize ' . line('$')
    silent! redraw
    silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
    silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . command . ''')<cr>'
    echo 'Shell command ' . command . ' executed.'
endfunction
command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)

" Autocommands

" Goto last location in non-empty files
autocmd BufReadPost *  if line("'\"") > 1 && line("'\"") <= line("$")
                   \|     exe "normal! g`\""
                   \|  endif

" Create directories if they don't exist on write
function! s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction

augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

" FileType: Javascript
augroup filetype_javascript
    autocmd!
    autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 expandtab
    autocmd FileType javascript setlocal equalprg=python\ c:\\Python27\\Scripts\\js-beautify\ --indent-size=2\ -X\ --stdin
augroup END

" FileType: Ruby
augroup filetype_ruby
    autocmd!
    autocmd FileType ruby setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
augroup END

" Filetype: RC
augroup filetype_rc
    autocmd!
    autocmd FileType rc setlocal textwidth=0 noautoindent
augroup END

" Filetype: Jenkinsfile
augroup filetype_Jenkinsfile
    autocmd!
    autocmd BufNewFile,BufRead * if expand('%') == 'Jenkinsfile' | set ft=groovy | endif
augroup END

" Filetype: groovy
augroup filetype_groovy
    autocmd!
    autocmd FileType groovy setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
augroup END

augroup vimrc_note
    autocmd!
    autocmd Syntax * syn match MyTodo /\v<(NOTE)/ containedin=.*Comment.*,vimCommentTitle
augroup END
hi def link MyTodo Todo

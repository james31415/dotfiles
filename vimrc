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

Plugin 'romainl/flattened'

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

Plugin 'mileszs/ack.vim'
if executable('rg')
    let g:ackprg = 'rg --vimgrep'
endif

Plugin 'jelera/vim-javascript-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'nathanaelkane/vim-indent-guides'
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

set autoindent

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
set backupcopy=yes

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
function! TabToggle()
    if &expandtab
        set tabstop=3
        set shiftwidth=3
        set softtabstop=0
        set noexpandtab
    else
        set tabstop=4
        set shiftwidth=4
        set softtabstop=4
        set expandtab
    endif
endfunction
" Mapping defined below

" Mappings
let mapleader=","

vmap Q gq
nmap Q gqap

" Remember: Indent Guides defines <Leader>ig

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
nnoremap <silent> <F9> mz:execute TabToggle()<cr>'z

nnoremap <silent> <F11> :TagbarToggle<cr>

" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

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
function! Eatchar(pat)
    let c = nr2char(getchar(0))
    return (c =~ a:pat) ? '' : c
endfunction

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

" Filetype: C,CPP
augroup filetype_c
    autocmd!
    autocmd FileType c,cpp let g:headerguard_newline=1
    autocmd FileType c,cpp setlocal cinoptions=(0,=0
")

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
    autocmd FileType javascript setlocal equalprg=js-beautify\ --indent-size=2\ -X\ --stdin
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

" Filetype: VIM
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal formatoptions-=cro
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

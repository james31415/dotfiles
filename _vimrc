" Enables pathogen plugin {{{
call pathogen#infect()
"}}}

let mapleader=","

" Paths etc. {{{
source ~/settings.vim
"}}}

" Options {{{
" Graphical settings {{{
colorscheme pablo
set guifont=Bitstream_Vera_Sans_Mono:h12
set statusline=%<%f\ %y\ %h%m%r%=%-14.(%l,%c%V%)\ %P\ %{fugitive#statusline()}
set guioptions-=T
set guioptions-=m
"}}}

" Options for folding {{{
set foldmethod=marker
set foldlevel=99
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
set incsearch
set ignorecase
set laststatus=2
set backspace=2
set confirm
set wildmenu

if ($OS =~ "Windows")
    let g:netrw_scp_cmd="pscp -q"
endif
"}}}
"}}}

" Mappings {{{
" Shell {{{
function! s:ExecuteInShell(command) " {{{
    let command = join(map(split(a:command), 'expand(v:val)'))
    let winnr = bufwinnr('^' . command . '$')
    silent! execute  winnr < 0 ? 'botright vnew ' . fnameescape(command) : winnr . 'wincmd w'
    setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap nonumber
    echo 'Execute ' . command . '...'
    silent! execute 'silent %!'. command
    silent! redraw
    silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
    silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . command . ''')<CR>:AnsiEsc<CR>'
    silent! execute 'nnoremap <silent> <buffer> q :q<CR>'
    silent! execute 'AnsiEsc'
    echo 'Shell command ' . command . ' executed.'
endfunction " }}}
command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)
nnoremap <leader>! :Shell 
"}}}

nnoremap <space> @@
inoremap jk <Esc>

" Special Files {{{
nnoremap <Leader>ev :e $MYVIMRC<cr>
"}}}

" Fugitive {{{
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gci :Gcommit<cr>
nnoremap <leader>gm :Gmove<cr>
nnoremap <leader>gr :Gremove<cr>
nnoremap <leader>gl :Shell git gl -18<cr>:wincmd \|<cr>

augroup ft_fugitive
    au!

    au BufNewFile,BufRead .git/index setlocal nolist
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
"}}}

" Function Key definitions {{{
nnoremap <silent> <F6> :TlistToggle<cr>
nnoremap <silent> <F7> :set hls!<cr>
nnoremap <silent> <F8> :set nu!<cr>
nnoremap <silent> <C-F2> :if &guioptions =~# 'T' <Bar>
                         \set guioptions-=T <Bar>
                         \set guioptions-=m <Bar>
                    \else <Bar>
                         \set guioptions+=T <Bar>
                         \set guioptions+=m <Bar>
                    \endif<cr>
nnoremap <silent> <F12> :e #<cr>
"}}}
"}}}

" Autocommands {{{
function! Eatchar(pat)
	let c = nr2char(getchar(0))
	return (c =~ a:pat) ? '' : c
endfunction

" Filetype: Python {{{
augroup filetype_python
    autocmd!
    autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab foldmethod=indent
    autocmd FileType python iabbrev <buffer> iff if:<left>
    autocmd FileType python iabbrev <buffer> eli elif:<left>
    autocmd FileType python iabbrev <buffer> imp import
    autocmd FileType python iabbrev <buffer> ret return()<left><c-r>=Eatchar('\s')<cr>
    autocmd FileType python iabbrev <buffer> return Use ret instead.
    autocmd FileType python iabbrev <buffer> if Use iff instead.
augroup END
"}}}

" Filetype: VIM {{{
augroup filetype_vim
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType vim let b:surround_34 = "\"{{{ \r \"}}}"
augroup END
"}}}
"}}}


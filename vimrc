set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'wincent/Command-T.git'
Plugin 'kien/ctrlp.vim'
Plugin 'christoomey/vim-tmux-navigator.git'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'ervandew/supertab'
Plugin 'fatih/vim-go'

call vundle#end()

syntax on
filetype plugin indent on

if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

if has("autocmd")
    autocmd BufWritePost * GitGutter
endif

augroup mkd
  autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:&gt;
augroup END

set hidden
set noswapfile

set incsearch
set hlsearch
set ignorecase
set smartcase

set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set expandtab
set background=dark

set scrolloff=5

set undodir=~/.vim/undodir
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

" vim workspace

set wildmenu
set wildmode=list:longest
set wildignore+=*.o,*.obj,*.git,*.crt,*.pyc,*.so,*.exe

set wrap
set modeline
set modelines=2

imap jk <esc>
nnoremap <Space> @q

" NerdTree
map <F3> :NERDTreeToggle<cr>
let NERDTreeIgnore=['\.vim$', '\~$', '\.git$', '\.pyc$']

set laststatus=2 " always show status line
set statusline=
" set statusline+=%-3.3n " buffer number
set statusline+=%f " filename
set statusline+=%< " cut here if line's too long
set statusline+=%h%m%r%w " status flags
set statusline+=\ [%{strlen(&ft)?&ft:'none'}] " filetype
set statusline+=\ %{fugitive#statusline()} " fugitive Git branch
set statusline+=%= " right align remainder of status line
set statusline+=\ %14(%l,%c%V%) " line,col
set statusline+=\ %P " file position

" Command-T
let g:CommandTMaxFiles=120000
let g:CommandTMaxDepth=20

" CtrlP
let g:ctrlp_max_files=0
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|build)$',
  \ 'file': '\v\.(exe|so|dll|pyc|o|lib)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
let g:ctrlp_clear_cache_on_exit = 0

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Go support
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-n>"


" Syntastic

let g:syntastic_check_on_open=1
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_jump=0
let g:syntastic_enable_balloons = 1

let g:syntastic_python_flake8_args = "--max-line-length=100"
let g:syntastic_python_checkers = [ 'python', 'flake8', 'pylint', 'pep257' ]
"let g:syntastic_python_checkers = [ 'python' ]
"let g:syntastic_auto_loc_list=0


set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'airblade/vim-gitgutter'
Plugin 'christoomey/vim-tmux-navigator.git'
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'
Plugin 'lyuts/vim-rtags'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'

Plugin 'marciomazza/vim-brogrammer-theme'

call vundle#end()

if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

augroup mkd
  autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:&gt;
augroup END

" general
set hidden
set noswapfile

" searching
set incsearch
set hlsearch
set ignorecase
set smartcase

" indenting
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set expandtab


" theme
set termguicolors
set background=dark
colorscheme brogrammer

" appearence
set colorcolumn=80
set cursorline
set modeline
set modelines=2
set number
set scrolloff=5
set sidescroll=1
set vb t_vb=""
set wrap

" undo
set undodir=~/.vim/undodir
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

" status line
set laststatus=2 " always show status line
set statusline=
set statusline+=%-3.3n " buffer number
set statusline+=%f " filename
set statusline+=%< " cut here if line's too long
set statusline+=%h%m%r%w " status flags
set statusline+=\ [%{strlen(&ft)?&ft:'none'}] " filetype
set statusline+=\ %{fugitive#statusline()} " fugitive Git branch
set statusline+=%= " right align remainder of status line
set statusline+=\ %14(%l,%c%V%) " line,col
set statusline+=\ %P " file position

" wildmenu
set wildmenu
set wildmode=list:longest
set wildignore+=*.o,*.obj,*.git,*.crt,*.pyc,*.so,*.exe

" superflous whitspaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

"mappings
imap jk <esc>
nnoremap <Space> @q

" misc
syntax on
filetype plugin indent on


""" Plugin configuration """

" FZF
nmap ;         :Buffers<CR>
nmap <Leader>f :Files<CR>

" GitGutter
if has("autocmd")
    autocmd BufWritePost * GitGutter
endif

" NerdTree
map <F3> :NERDTreeToggle<cr>
let NERDTreeIgnore=['\.vim$', '\~$', '\.git$', '\.pyc$']

" rtags shortcuts
noremap gd :call rtags#JumpTo(g:SAME_WINDOW)<CR>
noremap gr :call rtags#FindRefs()<CR>
noremap gb :call rtags#JumpBack()<CR>

" Syntastic

let g:syntastic_check_on_open=1
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_jump=0
let g:syntastic_enable_balloons = 1

let g:syntastic_python_flake8_args = "--max-line-length=100"
let g:syntastic_python_checkers = [ 'python', 'flake8', 'pylint', 'pep257' ]
"let g:syntastic_python_checkers = [ 'python' ]
"let g:syntastic_auto_loc_list=0


set clipboard=exclude:.* " prevent vim from connecting to the X server

set nocompatible              " be iMproved, required
filetype off                  " required

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'christoomey/vim-tmux-navigator'
Plug 'fatih/vim-go', { 'tag': '*', 'for' : 'go' }
Plug 'rust-lang/rust.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'lyuts/vim-rtags', { 'for': ['c', 'cpp'] }
Plug 'mhinz/vim-signify'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-unimpaired'

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
set autowrite
set textwidth=79

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
set diffopt=vertical

" undo
set undodir=~/.vim_undodir
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

command WQ wq
command Wq wq
command W w
command Q q

nnoremap <F5> :bufdo e<CR>

" misc
syntax on
filetype plugin indent on


""" Plugin configuration """

" ClangFormat
autocmd FileType c,cpp map <tab> :py3f /usr/lib/clang-format/clang-format.py<cr>

" Rust Format
autocmd FileType rust map <tab> :RustFmt<cr>

" FZF
nmap ;         :Buffers<CR>
nmap <Leader>f :Files<CR>

" rtags shortcuts
noremap gd :call rtags#JumpTo(g:SAME_WINDOW)<CR>
noremap gr :call rtags#FindRefs()<CR>
noremap gb :call rtags#JumpBack()<CR>

" Signify
let g:signify_vcs_list = ['git']

" Get developer info from git config
funct! GitGetAuthor()
	" Strip terminating NULLs to prevent stray ^A chars (see :help system)
	return system('git config --null --get user.name | tr -d "\0"') .
	      \ ' <' . system('git config --null --get user.email | tr -d "\0"') . '>'
endfunc
map <Leader>ack :exe 'put =\"Acked-by: ' . GitGetAuthor() . '\"'<CR>
map <Leader>rev :exe 'put =\"Reviewed-by: ' . GitGetAuthor() . '\"'<CR>
map <Leader>sob :exe 'put =\"Signed-off-by: ' . GitGetAuthor() . '\"'<CR>
map <Leader>tst :exe 'put =\"Tested-by: ' . GitGetAuthor() . '\"'<CR>

map <Leader>c :exe 'put =\"Cheers,\nMatthias\n\"'<CR>

"Use TAB to complete when typing words, else inserts TABs as usual.
"Uses dictionary and source files to find matching words to complete.

"See help completion for source,
"Note: usual completion is on <C-n> but more trouble to press all the time.
"Never type the same word twice and maybe learn a new spellings!
"Use the Linux dictionary when spelling is in doubt.
"Window users can copy the file to their machine.
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction
inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
set dictionary+=/usr/share/dict/words

hi mailQuoted1	ctermfg=green
hi mailQuoted2	ctermfg=cyan
hi mailQuoted3	ctermfg=darkcyan
hi mailQuoted4	ctermfg=blue
hi mailQuoted5	ctermfg=blue
hi mailQuoted6	ctermfg=blue

" Include local configuration (touch it if it fails)
source ~/.vimrc.local

call plug#end()


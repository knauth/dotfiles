set nocompatible
syntax on
filetype plugin on
"noremap j h
"noremap k j
"noremap l k
"noremap ; l

call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'valloric/youcompleteme'
Plug 'vim-airline/vim-airline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
call plug#end()

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

set list

packadd! dracula
colorscheme dracula " a colorscheme
set background=dark

set tabstop=4 "sets spaces seen per tab to 4
set softtabstop=4 "how many tabs will be seen when I hit tab

"UI config
set number "shows line numbers

set cursorline "highlights the current line

set showmatch "highlight matching brackets and stuff

set incsearch "search as characters are entered
set hlsearch "highlight matches

"file search config 
"search down into sub folders (recursive searc)
set path+=** "provides tab-completion for all file-related tasks
set wildmenu "display all matching files when using tab-complete

syntax on
noremap j h 
"preferred keybindings
noremap k j
noremap l k
noremap ; l


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

hi Normal guibg=NONE ctermbg=NONE 
"transparent background

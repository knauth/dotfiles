syntax on
filetype plugin indent on

packadd! dracula
colorscheme dracula " a colorscheme
set background=dark

let mapleader =";"

call plug#begin()
  Plug 'preservim/nerdtree'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-fugitive'
  Plug 'jpalardy/vim-slime', { 'for': 'python' }
  Plug 'hanschen/vim-ipython-cell', { 'for': 'python' }
  Plug 'lervag/vimtex'
  Plug 'raghur/vim-ghost', {'do': ':GhostInstall'}
  Plug 'roxma/nvim-yarp', v:version >= 800 && !has('nvim') ? {} : { 'on': [], 'for': [] }
  Plug 'roxma/vim-hug-neovim-rpc', v:version >= 800 && !has('nvim') ? {} : { 'on': [], 'for': [] }
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
  Plug 'nvim-lua/plenary.nvim'	
  Plug 'BurntSushi/ripgrep'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'rhysd/vim-grammarous'
  Plug 'easymotion/vim-easymotion'
  Plug 'meatballs/notebook.nvim'
  Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
  Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
  Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()

lua require('notebook').setup()
lua lsp = require 'lspconfig'
lua coq = require 'coq'

lua lsp.jedi_language_server.setup(coq.lsp_ensure_capabilities())
let g:jedi#completions_enabled = 0
let g:jedi#show_call_signatures = 0
lua vim.diagnostic.disable()

set tabstop=4 "sets spaces seen per tab to 4
set softtabstop=4 "how many tabs will be seen when I hit tab

"UI config
set number "shows line numbers
set relativenumber

set cursorline "highlights the current line

set showmatch "highlight matching brackets and stuff

set incsearch "search as characters are entered
set hlsearch "highlight matches
set nocompatible

set clipboard=unnamedplus "Yank to clipboard

" EasyMotion config
map <Leader> <Plug>(easymotion-prefix)

"------------------------------------------------------------------------------
" slime configuration 
"------------------------------------------------------------------------------
" always use tmux
let g:slime_target = 'tmux'

" fix paste issues in ipython
let g:slime_python_ipython = 1

" always send text to the top-right pane in the current tmux tab without asking
let g:slime_default_config = {
            \ 'socket_name': 'default',
            \ 'target_pane': ':' }

let g:slime_dont_ask_default = 1

"------------------------------------------------------------------------------
" ipython-cell configuration
"------------------------------------------------------------------------------
" Keyboard mappings. <Leader> is \ (backslash) by default

" map <Leader>s to start IPython
nnoremap <Leader>s :SlimeSend1 ipython --matplotlib<CR>

" map <Leader>r to run script
nnoremap <Leader>r :w<CR>:IPythonCellRun<CR>

" map <Leader>R to run script and time the execution
nnoremap <Leader>R :IPythonCellRunTime<CR>

" map <Leader>c to execute the current cell
nnoremap <Leader>c :IPythonCellExecuteCell<CR>

" map <Leader>C to execute the current cell and jump to the next cell
nnoremap <Leader>C :IPythonCellExecuteCellJump<CR>

" map <Leader>l to clear IPython screen
nnoremap <Leader>l :IPythonCellClear<CR>

" map <Leader>x to close all Matplotlib figure windows
nnoremap <Leader>x :IPythonCellClose<CR>

" map [c and ]c to jump to the previous and next cell header
nnoremap [c :IPythonCellPrevCell<CR>
nnoremap ]c :IPythonCellNextCell<CR>

" map <Leader>h to send the current line or current selection to IPython
nmap <Leader>h <Plug>SlimeLineSend
xmap <Leader>h <Plug>SlimeRegionSend

" map <Leader>p to run the previous command
nnoremap <Leader>p :IPythonCellPrevCommand<CR>

" map <Leader>Q to restart ipython
nnoremap <Leader>Q :IPythonCellRestart<CR>

" map <Leader>d to start debug mode
nnoremap <Leader>d :SlimeSend1 %debug<CR>

" map <Leader>q to exit debug mode or IPython
nnoremap <Leader>q :SlimeSend1 exit<CR>

" map <F9> and <F10> to insert a cell header tag above/below and enter insert mode
nmap <F9> :IPythonCellInsertAbove<CR>a
nmap <F10> :IPythonCellInsertBelow<CR>a

" also make <F9> and <F10> work in insert mode
imap <F9> <C-o>:IPythonCellInsertAbove<CR>
imap <F10> <C-o>:IPythonCellInsertBelow<CR>

" map <F5> to save and run script
nnoremap <F5> :w<CR>:IPythonCellRun<CR>
inoremap <F5> <C-o>:w<CR><C-o>:IPythonCellRun<CR>

"vimtex configuration
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_method = 'latexmk'
nnoremap <Leader>v :VimtexView<CR>

"file search config 
"search down into sub folders (recursive searc)
set path+=** "provides tab-completion for all file-related tasks
set wildmenu "display all matching files when using tab-complete

"transparent background
hi Normal guibg=NONE ctermbg=NONE 

nnoremap <leader>tt <cmd>Telescope<cr>
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>fc <cmd>lua require('telescope.builtin').git_commits()<cr>
nnoremap <leader>fo <cmd>lua require('telescope.builtin').oldfiles()<cr>

command! W w
command! Erc 'e /home/june/.vimrc'

let g:ycm_semantic_triggers =  {
    \   'c': ['->', '.'],
    \   'objc': ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
    \            're!\[.*\]\s'],
    \   'ocaml': ['.', '#'],
    \   'cpp,cuda,objcpp': ['->', '.', '::'],
    \   'perl': ['->'],
    \   'php': ['->', '::'],
    \   'cs,d,elixir,go,groovy,java,javascript,julia,perl6,python,scala,typescript,vb': ['.'],
    \   'ruby,rust': ['.', '::'],
    \   'lua': ['.', ':'],
    \   'erlang': [':'],
    \      }

COQnow --shut-up

set nocompatible
syntax on
filetype plugin indent on

set number
set ruler
set cursorline

set tabstop=4
set shiftwidth=4
set expandtab
set smartindent

set nowrap
set ignorecase
set smartcase
set hlsearch
set incsearch

set hidden
set mouse=a
set clipboard=unnamedplus

" Keymaps
nnoremap <Space> :nohlsearch<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" QoL
set laststatus=2
set showcmd
set wildmenu
set backspace=indent,eol,start

colorscheme tokyonight
set background=dark

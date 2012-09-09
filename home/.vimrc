set nocompatible

syntax on
filetype on
colorscheme gummybears

if has("gui_running")
    set guifont=Dejavu\ Sans\ Mono\ Book\ 9
    set lines=35 columns=100
endif

set nocompatible
set shortmess+=I
set history=100
set ruler
set showmode
set showmatch
set wrap
set number

set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent

set nobackup
set nowritebackup
set noswapfile
set laststatus=2
set encoding=utf-8

map ; :
map <F2> :w<CR>
imap <F2> <ESC>:w<CR>li
map <F10> :q!<CR>
imap <F10> <ESC>:q!<CR>
nmap <S-tab> :tabnext<cr>

nmap <leader>bv :bel vsp 
nmap <leader>bh :bel sp 

nmap <F12> :set number!<Bar>set number?<CR>
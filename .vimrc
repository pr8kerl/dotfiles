syntax enable
" set background=light
colorscheme nord
set ts=2
set number
" set mouse=r
" set foldmethod=syntax
" set foldnestmax=1
set paste
set encoding=utf-8
set nofixendofline

" Some Linux distributions set filetype in /etc/vimrc.
" Clear filetype flags before changing runtimepath to force Vim to reload them.
filetype off
filetype plugin indent off
" set runtimepath+=$GOROOT/misc/vim

execute pathogen#infect()
syntax on
filetype plugin indent on

let g:vim_json_syntax_conceal = 0

set guifont=Envy\ Code\ R\ 14

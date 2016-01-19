syntax enable
set background=dark
colorscheme solarized
set ts=2
set number
set mouse=a
" set foldmethod=syntax
" set foldnestmax=1

" Some Linux distributions set filetype in /etc/vimrc.
" Clear filetype flags before changing runtimepath to force Vim to reload them.
filetype off
filetype plugin indent off
set runtimepath+=$GOROOT/misc/vim

execute pathogen#infect()
syntax on
filetype plugin indent on


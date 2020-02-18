"Vundle plugin manager
set shell=/bin/zsh
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'mboughaba/i3config.vim'
Plugin 'vifm/vifm.vim'
Plugin 'dracula/vim'
Plugin 'morhetz/gruvbox'
Plugin 'itchyny/lightline.vim'
Plugin 'vim-airline/vim-airline'
call vundle#end()
filetype plugin indent on

"Basic configuration
set number
set mouse=a
"set bg=light
set wildmode=longest,list,full
set clipboard=unnamedplus
vnoremap <C-c> "+y
map <C-p> "+P
autocmd BufWritePre * %s/\s\+$//e
syntax on
colorscheme dracula
"let g:airline_powerline_fonts = 1
"let g:airline#extensions#tabline#enabled = 1

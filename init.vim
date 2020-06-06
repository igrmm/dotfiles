"Vundle plugin manager
set shell=/bin/zsh
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'vifm/vifm.vim'
Plugin 'dracula/vim'
Plugin 'itchyny/lightline.vim'
Plugin 'junegunn/fzf.vim'
Plugin 'preservim/nerdtree'
call vundle#end()
filetype plugin indent on

"Basic configuration
set nu rnu
set mouse=a
set wildmode=longest,list,full
set clipboard=unnamedplus
vnoremap <C-c> "+y
map <C-p> "+P
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'window': { 'width': 0.2, 'height': 0.9, 'xoffset': 1 }})
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, '--word-regexp', <bang>0)
autocmd BufWritePre * %s/\s\+$//e
syntax on
colorscheme dracula
let g:lightline = { 'colorscheme': 'dracula' }

au BufNewFile,BufRead *.txt set tw=80

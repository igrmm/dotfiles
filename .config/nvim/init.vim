if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'vifm/vifm.vim'
Plug 'dracula/vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

"Basic configuration
syntax on
filetype plugin indent on
set nu rnu
set mouse=a
set wildmode=longest,list,full
set clipboard=unnamedplus
autocmd BufWritePre * %s/\s\+$//e
au BufNewFile,BufRead *.txt set tw=80

"Plugins
colorscheme dracula
set termguicolors
let g:lightline = { 'colorscheme': 'dracula' }

"Maps
vnoremap <C-c> "+y
map <C-p> "+P

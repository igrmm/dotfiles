" Vim plug autoinstall
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

"Plugins
colorscheme dracula
set termguicolors
let g:lightline = { 'colorscheme': 'dracula' }
let g:coc_global_extensions = ['coc-json', 'coc-explorer']

"Basic configuration
set nu rnu                            " Enable numers
set wildmode=longest,list,full        " Popup with completions
set clipboard=unnamedplus             " Copy to clipboard
autocmd BufWritePre * %s/\s\+$//e     " Remove trailing chars
au BufNewFile,BufRead *.txt set tw=80 " Max cols =80
set tabstop=4                         " Size of a hard tabstop (ts).
set shiftwidth=4                      " Size of an indentation (sw).
set expandtab                         " Always uses spaces instead of tab characters (et).
set softtabstop=0                     " Number of spaces a <Tab> counts for. When 0, featuer is off (sts).

"Maps
vnoremap <C-c> "+y
map <C-p> "+P
nmap <space>e <Cmd>CocCommand explorer<CR>
nmap <space>f <Cmd>Files<CR>
nmap <space>b <Cmd>Buffers<CR>

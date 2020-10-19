syntax on

set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set incsearch
set nobackup
set undodir=~/.nvim/undodir
set undofile
set updatetime=300

" plugins
call plug#begin('~/.nvim/plugged')

" comments
Plug 'scrooloose/nerdcommenter'

" code completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" file-tree
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" statusbar
Plug 'bling/vim-airline'

" theme
Plug 'morhetz/gruvbox'

call plug#end()

" set theme
colorscheme gruvbox

" keybindings
nmap <C-n> :NERDTreeToggle<CR>
vmap <C-_> <plug>NERDCommenterToggle
nmap <C-_> <plug>NERDCommenterToggle

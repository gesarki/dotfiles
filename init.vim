set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
set packpath=~/.vim,/usr/share/vim/vimfiles,/usr/share/vim/vim80,/usr/share/vim/vimfiles/after,~/.vim/after
source ~/.vimrc
call plug#begin('~/.vim/plugged')
Plug 'mileszs/ack.vim'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-vinegar'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'quramy/tsuquyomi'
Plug 'leafgarland/typescript-vim'
call plug#end()

autocmd vimenter * colorscheme gruvbox
" setting gruvbox theme
let g:airline_theme='gruvbox' " set airline theme
autocmd vimenter * AirlineRefresh

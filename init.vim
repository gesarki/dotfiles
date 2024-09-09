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
Plug 'andymass/vim-matchup'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive' " git commands
Plug 'tpope/vim-rhubarb' " open file in github in browser
call plug#end()

autocmd vimenter * colorscheme gruvbox
" setting gruvbox theme
let g:airline_theme='gruvbox' " set airline theme
let g:airline#extensions#tabline#enabled = 1 " show all buffers when 1 tab open
autocmd vimenter * AirlineRefresh

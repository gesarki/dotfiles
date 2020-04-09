syntax on

" enter current millenium
set nocompatible

" enable plugins
filetype plugin on

" search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" display all matching files when we tab complete
set wildmenu
set wildignore+=**/node_modules/**


" create the `tags` file
command! MakeTags  !ctags -R .

"" Tweaks for browsing
"let g:netrw_browse_split=4 " open in prior window
"let g:netrw_altv=1 " open splits to the right
"let g:netrw_liststyle=3 " tree view
"let g:netrw_list_hide=netrw_gitignore#Hide()
"let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
"" - :edit a folder to open a file browser
"" - <CR>/v/t to open in an h-split/v-split/tab
"" - check |netrw-browse-maps| for more mappings

" show what you're typing on the bottom
set showcmd

set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

" disable arrow keys in insert and normal mode
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

syntax on

" enter current millenium
set nocompatible

" show current filename all the time
set laststatus=2

" enable plugins
filetype plugin on

" allow dictionary autocomplete when set spell is on
set complete+=kspell

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
let g:netrw_preview   = 1
let g:netrw_liststyle = 3
let g:netrw_winsize   = 30
let g:netrw_liststyle=3 " tree view
"" fix for netrw stopping q due to some buffer not saved
autocmd FileType netrw setlocal bufhidden=delete
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
set smartcase
set noswapfile
set nobackup
" create a undodir if it doesn't exist yet
if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=~/.vim/undo-dir
set undofile
set incsearch

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey
set nohlsearch
set nowrap

set cursorline " highlights cursor's line and linenum

" disable arrow keys in insert and normal mode
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

" auto-insert closing } when typing {
inoremap {<CR>  {<CR>}<Esc>O

" ignore case when searching unless search includes capital
set ignorecase
set smartcase

set termguicolors
set background=dark     "setting dark mode
highlight LineNr term=bold cterm=NONE ctermfg=DarkGray ctermbg=NONE

" sync the system and vim clipboard
set clipboard=unnamedplus

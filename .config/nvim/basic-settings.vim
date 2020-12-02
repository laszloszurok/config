"""""""""""""""""""""""""""""""
"           GENERAL           "
"""""""""""""""""""""""""""""""

" :W writes the file as sudo. (The SUDO_ASKPASS environmental variable
" has to be set to the path of a script that asks for the sudo password.)
com -bar W exe 'w !sudo tee >/dev/null %:p:S' | setl nomod

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" enable hiding of a buffer, even if it has unsaved changes
set hidden

" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Use system clipboard
set clipboard+=unnamedplus

" Don't redraw while executing macros (good performance config)
set lazyredraw 

" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile

" Better behaviour for opening splits
set splitbelow
set splitright

""""""""""""""""""""""""""""""""""""""
"           USER INTERFACE           " 
""""""""""""""""""""""""""""""""""""""

" When running nvim without arguments make sure to run startify first
" and then open Defx file tree
autocmd VimEnter *
            \   if !argc()
            \ |   Startify
            \ |   Defx -split=vertical -winwidth=40 -direction=topleft
            \ |   wincmd w
            \ | endif

" Enable true colors
if (has("termguicolors"))
  set termguicolors
endif

try
    colorscheme dracula
catch
endtry

set background=dark

" Always show the tabline
set showtabline=2

" Always show the status line
set laststatus=2

" Info to show in the status line
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

" Auto completition in vim's command bar
set wildmode=longest,list,full

" Highlight the line where the cursor is
set cursorline

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Line numbers
set number relativenumber
highlight LineNr ctermfg=grey

" Mouse support
set mouse=a

"Always show current position
set ruler

" Height of the command bar
set cmdheight=1

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Do not highlight search results
set nohlsearch

" Makes search act like search in modern browsers
set incsearch 

" Show matching brackets when text indicator is over them
set showmatch 


""""""""""""""""""""""""""""""""""""""""
"       TEXT AND INDENT RELATED        "
""""""""""""""""""""""""""""""""""""""""

" Use spaces instead of tabs
set expandtab

" When on, a <Tab> in front of a line inserts blanks according to 'shiftwidth'.
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

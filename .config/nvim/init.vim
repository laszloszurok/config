""""""""""""""""""""""""""""""""
"           INCLUDES           "
""""""""""""""""""""""""""""""""

source ~/.config/nvim/plugins.vim
source ~/.config/nvim/mappings.vim
source ~/.config/nvim/statusline.vim
source ~/.config/nvim/helpers.vim


"""""""""""""""""""""""""""""""
"           GENERAL           "
"""""""""""""""""""""""""""""""

" :W writes the file as sudo. (The SUDO_ASKPASS environmental variable
" has to be set to the path of a script that asks for the sudo password.)
com -bar W exe 'w !sudo tee >/dev/null %:p:S' | setl nomod

" Set working directory to the current files directory
autocmd BufEnter * lcd %:p:h

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


""""""""""""""""""""""""""""""""""""""
"           USER INTERFACE           " 
""""""""""""""""""""""""""""""""""""""

" Enable true colors
if (has("termguicolors"))
  set termguicolors
endif

try
    colorscheme palenight
catch
endtry

set background=dark

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


""""""""""""""""""""""""""""""""""""""""""""""""""""
"       TEXT, TABULATION AND INDENT RELATED        "
""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
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


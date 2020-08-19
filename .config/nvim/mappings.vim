" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = " "

map <leader>f :YcmCompleter FixIt<cr>

" Fast saving
nmap <leader>w :w!<cr>

" Shortcut for NerdTree
map <leader>n :NERDTreeToggle<cr>

" Leader + g to toggle Goyo (Have to set the colors, otherwise they are overwritten)
map <leader>g :Goyo \| colorscheme palenight\| set background=dark \| highlight LineNr ctermfg=grey  \| set linebreak<CR>

" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using Ctrl+ALT+[jk] (visual selection to move multiple lines)
nmap <C-M-j> mz:m+<cr>`z
nmap <C-M-k> mz:m-2<cr>`z
vmap <C-M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <C-M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
map <leader><leader>t :tabnew<cr>
map <leader><leader>o :tabonly<cr>
map <leader><leader>c :tabclose<cr>
map <leader><leader>m :tabmove 
map <leader><leader>n :tabnext<cr>
map <leader><leader>p :tabnext -<cr>

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Don't lose visual selection after change of indent level
vmap < <gv
vmap > >gv

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

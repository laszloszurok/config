" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = " "

" Fast saving
nmap <leader>w :w!<cr>

" Shortcuts for NerdTree
map <leader>e :NERDTreeToggle<cr>
map <leader>cd :cd %:p:h<cr>:pwd<cr>:NERDTreeCWD<cr>:wincmd w<cr>

" Leader + g to toggle Goyo
map <leader>g :Goyo <cr> 

" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using Ctrl+ALT+[jk] (visual selection to move multiple lines)
nmap <C-M-j> mz:m+<cr>`z
nmap <C-M-k> mz:m-2<cr>`z
vmap <C-M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <C-M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Faster way to move between splits
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Switch between buffers
map <leader>bn :bnext<cr>
map <leader>bp :bprevious<cr>
nmap <leader>bc :Bclose<cr>
nnoremap <leader>bl :Buffers<cr>

" Cycle through buffers with tab and shift+tab
nnoremap <TAB> :bnext<CR>
nnoremap <S-TAB> :bprevious<CR>

" Useful mappings for managing tabs
map <leader><leader>t :tabnew<cr>
map <leader><leader>c :tabclose<cr>
map <leader><leader>n :tabnext<cr>
map <leader><leader>p :tabprevious<cr>

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Don't lose visual selection after change of indent level
vmap < <gv
vmap > >gv

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Paste 'forgets' the copied content after the first paste
" by default. This solves the issue
xnoremap p pgvy

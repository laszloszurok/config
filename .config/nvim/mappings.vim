" More complex mappings, which use the leader key are in the whichkey 
" plugin configuration file (~/.config/nvim/plug-config/which-key.vim)
let mapleader = " "

" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using Ctrl+ALT+[jk] (visual selection to move multiple lines)
nmap <C-M-j> mz:m+<cr>`z
nmap <C-M-k> mz:m-2<cr>`z
vmap <C-M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <C-M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Faster way to move between splits
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Cycle through buffers with tab and shift+tab
nnoremap <TAB> :bnext<CR>
nnoremap <S-TAB> :bprevious<CR>

" Don't lose visual selection after change of indent level
vmap < <gv
vmap > >gv

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Paste 'forgets' the copied content after the first paste
" by default. This solves the issue
xnoremap p pgvy

" scroll with ctrl+u/d
map <c-d> <c-e>
map <c-u> <c-y>

" exit from terminal mode faster 
tnoremap <C-\> <C-\><C-n>

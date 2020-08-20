"""""""""""""""""""""""""""""""
"           PLUGINS           "
"""""""""""""""""""""""""""""""

" Automatically install vim-plug plugin manager if it is not installed already
if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'junegunn/goyo.vim'
Plug 'Valloric/YouCompleteMe'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'ap/vim-css-color'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdtree'
Plug 'justinmk/vim-sneak'
call plug#end()

" Show hidden files in NerdTree
let NERDTreeShowHidden=1

" Pressing s or S after a sneak search moves you to the next or previous match
let g:sneak#s_next = 1 

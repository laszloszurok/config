" Automatically install vim-plug plugin manager and plugins
if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
	autocmd VimEnter * CocInstall coc-emmet
endif

call plug#begin('~/.config/nvim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dart-lang/dart-vim-plugin'
Plug 'natebosch/vim-lsc'
Plug 'natebosch/vim-lsc-dart'
Plug 'jiangmiao/auto-pairs'

Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'ap/vim-css-color'

Plug 'laszloszurok/palenight.vim'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'junegunn/goyo.vim'
Plug 'mhinz/vim-startify'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'preservim/nerdtree'
Plug 'airblade/vim-rooter'
Plug 'voldikss/vim-floaterm'
Plug 'liuchengxu/vim-which-key'

Plug 'mattn/emmet-vim'

Plug 'justinmk/vim-sneak'
call plug#end()

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
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dart-lang/dart-vim-plugin'
Plug 'natebosch/vim-lsc'
Plug 'natebosch/vim-lsc-dart'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'ap/vim-css-color'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdtree'
Plug 'justinmk/vim-sneak'
Plug 'mhinz/vim-startify'
Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
Plug 'lotabout/skim.vim'
Plug 'vifm/vifm.vim'
call plug#end()

" Show hidden files in NerdTree
let NERDTreeShowHidden=1

" Pressing s or S after a sneak search moves you to the next or previous match
let g:sneak#s_next = 1 

" Startify header
let g:startify_custom_header = [
            \ '                          _           ',
            \ '    _ __   ___  _____   _(_)_ __ ___  ',
            \ '   | `_ \ / _ \/ _ \ \ / / | `_ ` _ \ ',
            \ '   | | | |  __/ (_) \ V /| | | | | | |',
            \ '   |_| |_|\___|\___/ \_/ |_|_| |_| |_|',
            \]

" select coc completition suggestions with tab
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger coc completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Auto-select the first completion item when pressing enter
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

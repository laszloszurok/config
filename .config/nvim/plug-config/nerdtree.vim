let g:NERDTreeWinSize=40
let NERDTreeMapToggleHidden='.'
let NERDTreeMapOpenVSplit='V'
let NERDTreeMapOpenSplit='H'
let NERDTreeMapChangeRoot='l'
let NERDTreeMapUpdir='h'
let NERDTreeMinimalUI = 1

" Close nerdtree if it is the last window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"Lightline colorscheme and tabline settings
let g:lightline = {
      \ 'enable': { 'tabline': 1 },
      \ 'colorscheme': 'tokyonight',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'tabline': {
      \   'right': [ [''] ],
      \   'left': [ ['buffers'] ],
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers'
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel'
      \ }
      \ }

let g:lightline.subseparator = { 'left': '', 'right': '' }

" enable switching between buffers by clicking on them in the top buffer line
let g:lightline.component_raw = {'buffers': 1}
let g:lightline#bufferline#clickable = 1

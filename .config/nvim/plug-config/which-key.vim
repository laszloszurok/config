" Map leader to which_key
nnoremap <silent> <leader> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

" Set to 1 to center the text in the which_key popup
let g:which_key_centered = 0

" Set to 1 to show a vertical list
let g:which_key_vertical = 0

" Create map to add keys to
let g:which_key_map =  {}

" Define a separator
let g:which_key_sep = '→'

" How fast the popup shows up
set timeoutlen=100

" Not a fan of floating windows for this
let g:which_key_use_floating_win = 0

" Change the colors if you want
highlight default link WhichKey          Operator
highlight default link WhichKeySeperator DiffAdded
highlight default link WhichKeyGroup     Identifier
highlight default link WhichKeyDesc      Function

" Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

" Single mappings (functions are defined in ~/.config/nvim/helpers.vim)
let g:which_key_map['w'] = [ ':w!'                        , 'write' ]
let g:which_key_map['q'] = [ ':q'                         , 'quit' ]
let g:which_key_map['e'] = [ ':call ToggleDefx()'         , 'toggle defx' ]
let g:which_key_map['r'] = [ ':call RefreshDefx()'        , 'refresh defx' ]
let g:which_key_map['g'] = [ ':Goyo'                      , 'goyo' ]
let g:which_key_map['S'] = [ ':Dashboard'                 , 'start screen' ]
let g:which_key_map['h'] = [ '<C-W>s'                     , 'split below' ]
let g:which_key_map['v'] = [ '<C-W>v'                     , 'split right' ]

" manage buffers
let g:which_key_map.b = {
    \ 'name' : '+buffers',
    \ 'e' : [':enew'     , 'empty buffer'],
    \ 'n' : [':bnext'    , 'next buffer'],
    \ 'p' : [':bprevious', 'previous buffer'],
    \ 'c' : [':Bclose'   , 'close buffer'],
    \ 'l' : [':Buffers'  , 'list buffers'],
  \ }

" mange tabs
let g:lasttab = 1 " Let 'tl' toggle between this and the last accessed tab
au TabLeave * let g:lasttab = tabpagenr()
let g:which_key_map.t = {
    \ 'name' : '+tabs',
    \ 't' : [':tabnew'                 , 'new tab'],
    \ 'n' : [':tabnext'                , 'next tab'],
    \ 'p' : [':tabprevious'            , 'previous tab'],
    \ 'c' : [':tabclose'               , 'close tab'],
    \ 'l' : [':exe "tabn ".g:lasttab'  , 'switch to last accessed tab']
  \ }

" toggle wrapping of lines
let g:which_key_map.l = {
    \ 'name' : '+linewrap',
    \ 'w' : [':set wrap'  , 'wrap'],
    \ 'n' : [':set nowrap', 'nowrap'],
  \ }

" s is for search
let g:which_key_map.s = {
      \ 'name' : '+search' ,
      \ '/' : [':History/'     , 'history'],
      \ ';' : [':Commands'     , 'commands'],
      \ 'a' : [':Ag'           , 'text Ag'],
      \ 'b' : [':BLines'       , 'current buffer'],
      \ 'B' : [':Buffers'      , 'open buffers'],
      \ 'c' : [':Commits'      , 'commits'],
      \ 'C' : [':BCommits'     , 'buffer commits'],
      \ 'f' : [':Files'        , 'files'],
      \ 'g' : [':GFiles'       , 'git files'],
      \ 'G' : [':GFiles?'      , 'modified git files'],
      \ 'h' : [':History'      , 'file history'],
      \ 'H' : [':History:'     , 'command history'],
      \ 'l' : [':Lines'        , 'lines'] ,
      \ 'm' : [':Marks'        , 'marks'] ,
      \ 'M' : [':Maps'         , 'normal maps'] ,
      \ 'p' : [':Helptags'     , 'help tags'] ,
      \ 'P' : [':Tags'         , 'project tags'],
      \ 's' : [':Snippets'     , 'snippets'],
      \ 'S' : [':Colors'       , 'color schemes'],
      \ 't' : [':Rg'           , 'text Rg'],
      \ 'T' : [':BTags'        , 'buffer tags'],
      \ 'y' : [':Filetypes'    , 'file types'],
      \ 'z' : [':FZF'          , 'FZF'],
      \ }

" floaterm commands
let g:which_key_map.f = {
      \ 'name' : '+floaterm' ,
      \ 'b' : [':FloatermNew --wintype=normal --height=9' , 'bottom terminal'],
      \ 'f' : [':FloatermToggle'                          , 'floating terminal'],
      \ 'g' : [':FloatermNew lazygit'                     , 'lazygit'],
      \ 'v' : [':FloatermNew vifm'                        , 'vifm'],
      \ }

" Register which key map
call which_key#register('<Space>', "g:which_key_map")

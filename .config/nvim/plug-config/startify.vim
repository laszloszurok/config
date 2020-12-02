" Startify header
let g:startify_custom_header = [
            \ '                          _           ',
            \ '    _ __   ___  _____   _(_)_ __ ___  ',
            \ '   | `_ \ / _ \/ _ \ \ / / | `_ ` _ \ ',
            \ '   | | | |  __/ (_) \ V /| | | | | | |',
            \ '   |_| |_|\___|\___/ \_/ |_|_| |_| |_|',
            \]

let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   Recent files']            },
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ ]

let g:startify_bookmarks = [
            \ { 'i': '~/.config/nvim/init.vim' },
            \ { 'z': '~/.config/zsh/.zshrc' },
            \ { 's': '~/scripts/' },
            \ { 'S': '~/suckless-builds/' },
            \ ]

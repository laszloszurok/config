let g:loaded_netrwPlugin = 1 " Disable netrw.vim

function! s:defx_my_settings() abort
    nnoremap <silent><buffer><expr> <CR>
                \ defx#do_action('open', 'wincmd w \| drop')

    nnoremap <silent><buffer><expr> c
                \ defx#do_action('copy')

    nnoremap <silent><buffer><expr> m
                \ defx#do_action('move')

    nnoremap <silent><buffer><expr> p
                \ defx#do_action('paste')

    nnoremap <silent><buffer><expr> dd
                \ defx#do_action('remove')

    nnoremap <silent><buffer><expr> r
                \ defx#do_action('rename')

    nnoremap <silent><buffer><expr> l
                \ defx#do_action('open', 'wincmd w \| drop')

    nnoremap <silent><buffer><expr> H
                \ defx#do_action('open', 'split')

    nnoremap <silent><buffer><expr> V
                \ defx#do_action('open', 'vsplit')

    nnoremap <silent><buffer><expr> P
                \ defx#do_action('preview')

    nnoremap <silent><buffer><expr> o
                \ defx#do_action('open_tree', 'toggle')

    nnoremap <silent><buffer><expr> D
                \ defx#do_action('new_directory')

    nnoremap <silent><buffer><expr> F
                \ defx#do_action('new_file')

    nnoremap <silent><buffer><expr> M
                \ defx#do_action('new_multiple_files')

    nnoremap <silent><buffer><expr> C
                \ defx#do_action('toggle_columns',
                \                'mark:indent:icon:filename:type:size:time')

    nnoremap <silent><buffer><expr> S
                \ defx#do_action('toggle_sort', 'time')

    nnoremap <silent><buffer><expr> !
                \ defx#do_action('execute_command')

    nnoremap <silent><buffer><expr> x
                \ defx#do_action('execute_system')

    nnoremap <silent><buffer><expr> yy
                \ defx#do_action('yank_path')

    nnoremap <silent><buffer><expr> .
                \ defx#do_action('toggle_ignored_files')

    nnoremap <silent><buffer><expr> ;
                \ defx#do_action('repeat')

    nnoremap <silent><buffer><expr> h
                \ defx#do_action('cd', ['..'])

    nnoremap <silent><buffer><expr> ~
                \ defx#do_action('cd')

    nnoremap <silent><buffer><expr> q
                \ defx#do_action('quit')

    nnoremap <silent><buffer><expr> <Space>
                \ defx#do_action('toggle_select')

    nnoremap <silent><buffer><expr> *
                \ defx#do_action('toggle_select_all')

    nnoremap <silent><buffer><expr> j
                \ line('.') == line('$') ? 'gg' : 'j'

    nnoremap <silent><buffer><expr> k
                \ line('.') == 1 ? 'G' : 'k'

    nnoremap <silent><buffer><expr> R
                \ defx#do_action('redraw')

    nnoremap <silent><buffer><expr> <C-g>
                \ defx#do_action('print')

    nnoremap <silent><buffer><expr> cd
                \ defx#do_action('change_vim_cwd')

endfunction

" function to be able to open directories in defx, like in netrw
function! s:open_defx_if_directory()
    try
        let l:full_path = expand(expand('%:p'))
    catch
        return
    endtry

    " If the path is a directory, delete the (useless) buffer and open defx for
    " that directory instead.
    if isdirectory(l:full_path)
        execute "Defx `expand('%:p')` | bd " . expand('%:r')
    endif
endfunction

augroup defx_config
    autocmd!
    autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'defx') | q | endif
    autocmd FileType defx call s:defx_my_settings()
    autocmd BufEnter * call s:open_defx_if_directory()
augroup END


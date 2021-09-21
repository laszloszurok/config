-- more complex plugin-related keybindings are in ./plugins/vim-which-key.lua

local map = vim.api.nvim_set_keymap

-- map the leader key
map('n', '<Space>', '', {})
vim.g.mapleader = ' '

local options = {noremap = true, silent = true}

-- press 0 to move the cursor to the first non-blank character on the current line
map('n', '0', '^', options)

-- cycle through buffers with tab and shift+tab
map('n', '<TAB>',   ':bnext<cr>', options)
map('n', '<S-TAB>', ':bprev<cr>', options)

-- move between splits using Ctrl+{h,j,k,l}
map('n', '<C-h>', '<C-w>h', options)
map('n', '<C-j>', '<C-w>j', options)
map('n', '<C-k>', '<C-w>k', options)
map('n', '<C-l>', '<C-w>l', options)

-- disable ctrl+z (suspends the editor)
map('', '<C-z>', '<Nop>', options)

-- move a line of text using Ctrl+ALT+[jk] (visual selection to move multiple lines)
map('n', '<C-M-j>', 'mz:m+<cr>`z', options)
map('n', '<C-M-k>', 'mz:m-2<cr>`z', options)
map('v', '<C-M-j>', ':m\'>+<cr>`<my`>mzgv`yo`z', options)
map('v', '<C-M-k>', ':m\'<-2<cr>`>my`<mzgv`yo`z', options)

-- don't lose visual selection after change of indent level
map('v', '<', '<gv', options)
map('v', '>', '>gv', options)

-- scroll with ctrl+u/d
map('n', '<C-d>', '<C-e>', options)
map('n', '<C-u>', '<C-y>', options)

-- exit from terminal mode with ctrl+\
map('t', '<C-\\>', '<C-\\><C-n>', options)

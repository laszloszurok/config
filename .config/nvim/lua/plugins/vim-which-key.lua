local wk = require('whichkey_setup')

wk.config {
    hide_statusline = true,
}

vim.g.which_key_centered = 0
vim.g.which_key_use_floating_win = 0

local keymap = {
    w = { ':w!<CR>', 'save file' },
    q = { ':q<cr>', 'quit' },
    g = { ':Goyo<cr>', 'goyo' },
    b = {
        name = '+buffers',
        e = { ':enew<cr>', 'new empty buffer' },
        n = { ':bnext<cr>', 'next buffer' },
        p = { ':bprev<cr>', 'previous buffer' },
        c = { ':Bdelete<cr>', 'close buffer' },
    },
    t = {
        name = '+tabs',
        o = { ':tabnew<cr>', 'open new tab' },
        n = { ':tabnext<cr>', 'next tab' },
        p = { ':tabprev<cr>', 'previous tab' },
        c = { ':tabclose<cr>', 'close tab' },
        r = { ':TablineTabRename ', 'rename tab' },
        a = { ':TablineToggleShowAllBuffers<cr>', 'show/hide all buffers on this tab' },
        b = { ':TablineBuffersBind ', 'bind buffers to this tab' },
        u = { ':TablineBuffersClearBind<cr>', 'unbind all buffers from this tab' },
    },
    s = {
        name = '+split',
        r = { ':vsplit<cr>', 'right' },
        b = { ':split<cr>', 'below' },
    },
    f = {
        name = '+find',
        f = {
            name = '+files',
            f = { '<cmd>Telescope find_files<cr>', 'files' },
            h = { '<cmd>Telescope oldfiles<cr>', 'history' },
        },
        t = { '<cmd>Telescope live_grep<cr>', 'text' },
        b = { '<Cmd>Telescope buffers<CR>', 'buffers' },
        h = { '<Cmd>Telescope help_tags<CR>', 'help tags' },
        c = {
            name = '+commands',
            c = { '<Cmd>Telescope commands<CR>', 'commands' },
            h = { '<Cmd>Telescope command_history<CR>', 'history' },
        },
        q = { '<Cmd>Telescope quickfix<CR>', 'quickfix' },
        g = {
            name = '+git',
            g = { '<Cmd>Telescope git_commits<CR>', 'commits' },
            c = { '<Cmd>Telescope git_bcommits<CR>', 'bcommits' },
            b = { '<Cmd>Telescope git_branches<CR>', 'branches' },
            s = { '<Cmd>Telescope git_status<CR>', 'status' },
        },
    },
    j = {
        name = '+jump',
        c = { "<cmd>lua require'hop'.hint_char1()<cr>", 'char' },
        l = { "<cmd>lua require'hop'.hint_lines()<cr>", 'line' },
    }
}

wk.register_keymap('leader', keymap)

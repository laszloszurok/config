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
    T = { ':!setsid -f $TERMINAL<cr><cr>' },
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
    },
    l = {
        name = '+lsp',
        g = {
            name = '+goto',
            d = { '<cmd>lua vim.lsp.buf.declaration()<CR>', 'declaration' },
            D = { '<cmd>lua vim.lsp.buf.definition()<CR>', 'definition' },
            i = { '<cmd>lua vim.lsp.buf.implementation()<CR>', 'implementation' },
            r = { '<cmd>lua vim.lsp.buf.references()<CR>', 'references' },
            n = { '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', 'next diagnostic' },
            p = { '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', 'prev diagnostic' },
        },
        d = { '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', 'diagnostics' },
        f = { '<cmd>lua vim.lsp.buf.formatting()<CR>', 'format' },
        r = { '<cmd>lua vim.lsp.buf.rename()<CR>', 'rename' },
        h = { '<cmd>lua vim.lsp.buf.hover()<CR>', 'hover' },
        H = { '<cmd>lua vim.lsp.buf.signature_help()<CR>', 'signature help' },
        w = { 
            name = '+workspace',
            a = { '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', 'add folder' },
            r = { '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', 'remove folder' },
            l = { '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', 'list folders' },
        },
        a = { '<cmd>lua vim.lsp.buf.code_action()<CR>', 'code action' },
        l = { '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', 'line diagnotics' },
        t = { '<cmd>lua vim.lsp.buf.type_definition()<CR>', 'type definition' },
        
    },
}

wk.register_keymap('leader', keymap)

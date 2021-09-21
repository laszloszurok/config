local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', install_path})
end

require 'paq' {
    'savq/paq-nvim';                  -- let paq manage itself
    'nvim-lua/plenary.nvim';          -- lua functions, used by telescope.nvim
    'nvim-telescope/telescope.nvim';  -- fuzzy find files, text, etc.
    'folke/tokyonight.nvim';          -- colorscheme
    'junegunn/goyo.vim';              -- center text, hide ui
    'liuchengxu/vim-which-key';       -- complex keybindings
    'AckslD/nvim-whichkey-setup.lua'; -- to be able to config vim-which-key in lua
    'famiu/bufdelete.nvim';           -- deleting a buffer won't mess up window layout
    'hoob3rt/lualine.nvim';           -- statusline
    'kdheepak/tabline.nvim';          -- tabline
    'windwp/nvim-autopairs';          -- auto-close brackets, quotation marks, etc.
    'lambdalisue/suda.vim';           -- easily edit readonly files
    'phaazon/hop.nvim';               -- jumpt to word, lines, etc. fast
    'glepnir/dashboard-nvim';         -- a simple startpage
    'lewis6991/gitsigns.nvim';        -- line signs, hunk actions, etc.
    'b3nj5m1n/kommentary';            -- comment out lines/visual selection

    -- code completion plugins
    'neovim/nvim-lspconfig';
    'hrsh7th/nvim-cmp';
    'hrsh7th/cmp-nvim-lsp';
    'hrsh7th/vim-vsnip';
    'hrsh7th/cmp-buffer';
    'hrsh7th/cmp-path';
}

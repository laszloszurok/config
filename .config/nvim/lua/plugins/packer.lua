local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the packer.lua file
vim.cmd [[
augroup packer_user_config
autocmd!
autocmd BufWritePost packer.lua source <afile> | PackerSync
augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end


-- Install your plugins here
return packer.startup(function(use)
    use "wbthomason/packer.nvim"         -- packer can manage itself
    use "nvim-lua/plenary.nvim"          -- useful lua functions used by lots of plugins
    use "liuchengxu/vim-which-key"       -- complex keybindings
    use "AckslD/nvim-whichkey-setup.lua" -- to be able to config vim-which-key in lua
    use "famiu/bufdelete.nvim"           -- deleting a buffer won't mess up the window layout
    use "hoob3rt/lualine.nvim"           -- statusline & tabline
    use "windwp/nvim-autopairs"          -- auto-close brackets, quotation marks, etc.
    use "lambdalisue/suda.vim"           -- easily edit readonly files
    use "phaazon/hop.nvim"               -- jump to characters, words, lines with keybindings
    use "junegunn/goyo.vim"              -- center text, hide ui
    use "lewis6991/gitsigns.nvim"        -- line signs, hunk actions, etc.
    use "b3nj5m1n/kommentary"            -- comment out lines/visual selection

    -- colorscheme
    use "folke/tokyonight.nvim"

    -- plugins for autocompletion
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "saadparwaiz1/cmp_luasnip"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-nvim-lua"

    -- autocomplete code snippets
    use "L3MON4D3/LuaSnip"             -- snippet engine
    use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

    -- language server protocol
    use "neovim/nvim-lspconfig" -- enable lsp

    -- better syntax highlight
    use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }

    -- clone packer and istall all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)

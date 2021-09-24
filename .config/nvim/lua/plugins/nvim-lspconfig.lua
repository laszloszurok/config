local nvim_lsp = require('lspconfig')

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'bashls', 'html', 'tsserver', 'clangd' }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        flags = {
            debounce_text_changes = 150,
        },
        capabilities = capabilities,
    }
end

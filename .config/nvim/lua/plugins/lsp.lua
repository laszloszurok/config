local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.bashls.setup{}

require'lspconfig'.pyright.setup{}

require'lspconfig'.clangd.setup{}

require'lspconfig'.tsserver.setup{}

require'lspconfig'.html.setup {
    capabilities = capabilities,
}

require'lspconfig'.cssls.setup {
    capabilities = capabilities,
}

require'lspconfig'.jsonls.setup {
    capabilities = capabilities,
}

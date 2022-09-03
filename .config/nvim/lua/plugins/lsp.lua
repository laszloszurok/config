local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.bashls.setup{}

require'lspconfig'.pyright.setup{}

require'lspconfig'.clangd.setup{}

require'lspconfig'.tsserver.setup{}

require'lspconfig'.html.setup {
    capabilities = capabilities,
    cmd = { '/usr/bin/vscode-html-languageserver', '--stdio' }
}

require'lspconfig'.cssls.setup {
    capabilities = capabilities,
    cmd = { '/usr/bin/vscode-css-languageserver', '--stdio' }
}

require'lspconfig'.jsonls.setup {
    capabilities = capabilities,
}

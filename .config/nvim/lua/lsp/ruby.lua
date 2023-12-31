-- If you are using rvm, make sure to change below configuration
-- Make sure that ruby < 3.x.x is installed since solargraph failed with 3.x

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

require'lspconfig'.solargraph.setup {
    cmd = { DATA_PATH .. "/lspinstall/ruby/solargraph/solargraph", "stdio"},
    capabilities = capabilities,
    on_attach = require'lsp'.common_on_attach,
    handlers = {
        ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = O.ruby.diagnostics.virtual_text,
            signs = O.ruby.diagnostics.signs,
            underline = O.ruby.diagnostics.underline,
            update_in_insert = true

        })
    },
    filetypes = O.ruby.filetypes,
}

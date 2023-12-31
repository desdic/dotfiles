-- requires yaml-language-server installed

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

require'lspconfig'.yamlls.setup{
  cmd = {"/usr/bin/yaml-language-server", "--stdio"},
  capabilities = capabilities
}

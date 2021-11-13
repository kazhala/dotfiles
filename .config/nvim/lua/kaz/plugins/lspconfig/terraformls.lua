local M = {}

function M.setup(on_attach, capabilities)
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  require('lspconfig').terraformls.setup({
    on_attach = on_attach,
    flags = { debounce_text_changes = 150 },
    capabilities = capabilities,
  })
end

return M

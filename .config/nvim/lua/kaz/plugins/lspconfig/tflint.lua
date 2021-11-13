local M = {}

function M.setup(on_attach, capabilities)
  require('lspconfig').tflint.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    flags = { debounce_text_changes = 150 },
  })
end

return M

local M = {}

function M.setup(on_attach)
  require('lspconfig').tflint.setup({
    on_attach = on_attach,
    flags = { debounce_text_changes = 150 },
  })
end

return M

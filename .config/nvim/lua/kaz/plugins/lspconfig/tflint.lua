local M = {}

function M.setup(on_attach)
  require('lspconfig').tflint.setup({
    on_attach = on_attach,
  })
end

return M

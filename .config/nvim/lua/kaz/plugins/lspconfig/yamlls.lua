local M = {}

function M.setup(on_attach)
  require('lspconfig').yamlls.setup({
    on_attach = on_attach,
    settings = {
      yaml = {
        validate = false,
        format = {
          enable = false,
        },
      },
    },
  })
end

return M

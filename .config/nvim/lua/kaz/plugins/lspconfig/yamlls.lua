local M = {}

function M.setup(on_attach, capabilities)
  require('lspconfig').yamlls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
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

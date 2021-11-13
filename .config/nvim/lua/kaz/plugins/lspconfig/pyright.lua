local M = {}

function M.setup(on_attach, capabilities)
  require('lspconfig').pyright.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    flags = { debounce_text_changes = 150 },
    settings = {
      pyright = { disableLanguageServices = false, disableOrganizeImports = true },
      python = {
        analysis = {
          useLibraryCodeForTypes = true,
          diagnosticMode = 'openFilesOnly',
        },
      },
    },
  })
end

return M

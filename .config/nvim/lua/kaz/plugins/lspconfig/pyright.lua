local util = require('lspconfig').util

local M = {}

function M.setup(on_attach)
  require('lspconfig').pyright.setup({
    on_attach = on_attach,
    flags = { debounce_text_changes = 150 },
    root_dir = util.root_pattern('.venv', 'venv', 'pyrightconfig.json'),
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

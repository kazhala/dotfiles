local util = require('lspconfig').util

local M = {}

function M.setup(on_attach)
  require('neodev').setup({})

  require('lspconfig').lua_ls.setup({
    lspconfig = {
      on_attach = on_attach,
      root_dir = util.root_pattern('.git', 'init.lua'),
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' },
          },
        },
      },
    },
  })
end

return M

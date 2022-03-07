local util = require('lspconfig').util

local M = {}

local sumneko_root_path = vim.fn.stdpath('data') .. '/lua-language-server'
local sumneko_binary = sumneko_root_path .. '/bin/' .. '/lua-language-server'

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

function M.setup(on_attach)
  require('lspconfig').sumneko_lua.setup(require('lua-dev').setup({
    lspconfig = {
      on_attach = on_attach,
      cmd = { sumneko_binary, '-E', sumneko_root_path .. '/main.lua' },
      root_dir = util.root_pattern('.git', 'init.lua'),
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' },
          },
        },
      },
    },
  }))
end

return M

local kb = require('kaz.utils.kb')
local npairs = require('nvim-autopairs')

npairs.setup({
  disable_filetype = { 'vim', 'TelescopePrompt' },
})

_G.MUtils = _G.MUtils or {}

MUtils.completion_confirm = function()
  return npairs.autopairs_cr()
end

vim.keymap.set('i', '<cr>', 'v:lua.MUtils.completion_confirm()', { expr = true })

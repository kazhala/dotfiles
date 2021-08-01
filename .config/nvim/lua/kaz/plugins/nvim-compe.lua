local kb = require('kaz.utils.kb')

require('compe').setup({
  enabled = true,
  autocomplete = true,
  source = {
    buffer = { kind = ' (text)' },
    path = { kind = ' (path)' },
    nvim_lua = false,
    nvim_lsp = true,
    spell = { kind = '﬜ (word)' },
  },
})

vim.api.nvim_set_keymap('i', '<C-Space>', 'compe#complete()', kb.silent_expr_noremap)
vim.api.nvim_set_keymap(
  'i',
  '<CR>',
  [[compe#confirm(luaeval("require 'nvim-autopairs'.autopairs_cr()"))]],
  kb.silent_expr_noremap
)
vim.api.nvim_set_keymap('i', '<C-e>', 'compe#close("<C-e>")', kb.silent_expr_noremap)
vim.api.nvim_set_keymap('i', '<C-j>', "compe#scroll({ 'delta': +4 })", kb.silent_expr_noremap)
vim.api.nvim_set_keymap('i', '<C-k>', "compe#scroll({ 'delta': -4 })", kb.silent_expr_noremap)

-- source: https://github.com/hrsh7th/nvim-compe#how-to-use-tab-to-navigate-completion-menu

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t('<C-n>')
  elseif check_back_space() then
    return t('<Tab>')
  else
    return vim.fn['compe#complete']()
  end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t('<C-p>')
  else
    return t('<S-Tab>')
  end
end

vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.tab_complete()', { expr = true })
vim.api.nvim_set_keymap('s', '<Tab>', 'v:lua.tab_complete()', { expr = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })
vim.api.nvim_set_keymap('s', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })

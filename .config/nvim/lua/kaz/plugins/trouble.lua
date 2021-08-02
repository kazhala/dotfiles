local kb = require('kaz.utils.kb')

require('trouble').setup({
  signs = {
    error = vim.g.diagnostic_icons.Error,
    warning = vim.g.diagnostic_icons.Warning,
    hint = vim.g.diagnostic_icons.Hint,
    information = vim.g.diagnostic_icons.Information,
    other = vim.g.diagnostic_icons.Other,
  },
})

vim.api.nvim_set_keymap('n', 'gr', '<CMD>Trouble lsp_references<CR>', kb.silent_noremap)
vim.api.nvim_set_keymap('n', 'gd', '<CMD>Trouble lsp_definitions<CR>', kb.silent_noremap)

vim.api.nvim_set_keymap('n', '<leader>dd', '<CMD>TroubleToggle<CR>', kb.silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>ds', '<CMD>TroubleToggle lsp_workspace_diagnostics<CR>', kb.silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>df', '<CMD>TroubleToggle lsp_document_diagnostics<CR>', kb.silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>dq', '<CMD>TroubleToggle quickfix<CR>', kb.silent_noremap)

vim.api.nvim_set_keymap(
  'n',
  ']g',
  '<CMD>lua require("trouble").next({skip_groups = true, jump = true})<CR>',
  kb.silent_noremap
)
vim.api.nvim_set_keymap(
  'n',
  '[g',
  '<CMD>lua require("trouble").previous({skip_groups = true, jump = true})<CR>',
  kb.silent_noremap
)

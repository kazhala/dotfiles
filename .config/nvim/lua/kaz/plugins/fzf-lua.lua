local actions = require('fzf-lua.actions')
local kb = require('kaz.utils.kb')

require('fzf-lua').setup({
  winopts = {
    hl = {
      border = 'FloatBorder',
    },
  },
  preview_layout = 'flex',
  flip_columns = 150,
  fzf_opts = {
    ['--border'] = 'none',
  },
  previewers = {
    builtin = {
      scrollbar = false,
    },
  },
  grep = {
    actions = {
      ['default'] = actions.file_edit_or_qf,
      ['ctrl-q'] = actions.file_sel_to_qf,
    },
  },
  buffers = {
    git_icons = false,
    actions = {
      ['ctrl-w'] = actions.buf_del,
      ['ctrl-q'] = actions.file_sel_to_qf,
    },
  },
  files = {
    fd_opts = [[--color never --type f --hidden --follow --strip-cwd-prefix]],
    git_icons = false,
    actions = {
      ['default'] = actions.file_edit,
      ['ctrl-q'] = actions.file_sel_to_qf,
    },
  },
  quickfix = {
    git_icons = false,
    actions = {
      ['default'] = actions.file_edit_or_qf,
      ['ctrl-q'] = actions.file_sel_to_qf,
    },
  },
  lsp = {
    async_or_timeout = false,
    severity = 'Warning',
    icons = {
      ['Error'] = { icon = vim.g.diagnostic_icons.Error, color = 'red' },
      ['Warning'] = { icon = vim.g.diagnostic_icons.Warning, color = 'yellow' },
      ['Information'] = { icon = vim.g.diagnostic_icons.Information, color = 'blue' },
      ['Hint'] = { icon = vim.g.diagnostic_icons.Hint, color = 'blue' },
    },
    actions = {
      ['default'] = actions.file_edit_or_qf,
      ['ctrl-q'] = actions.file_sel_to_qf,
    },
  },
})

vim.api.nvim_set_keymap('n', '<C-p>', [[<CMD>lua require('fzf-lua').files()<CR>]], kb.silent_noremap)
vim.api.nvim_set_keymap('n', '<C-m>', [[<CMD>lua require('fzf-lua').buffers()<CR>]], kb.silent_noremap)
vim.api.nvim_set_keymap('n', '<C-g>', [[<CMD>lua require('fzf-lua').live_grep()<CR>]], kb.silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>fs', [[<CMD>lua require('fzf-lua').live_grep_resume()<CR>]], kb.silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>fp', [[<CMD>lua require('fzf-lua').files_resume()<CR>]], kb.silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>ff', [[<CMD>lua require('fzf-lua').git_status()<CR>]], kb.silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>fw', [[<CMD>lua require('fzf-lua').grep_cWORD()<CR>]], kb.silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>fg', [[<CMD>lua require('fzf-lua').git_files()<CR>]], kb.silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>fm', [[<CMD>lua require('fzf-lua').marks()<CR>]], kb.silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>fy', [[<CMD>lua require('fzf-lua').registers()<CR>]], kb.silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>fh', [[<CMD>lua require('fzf-lua').help_tags()<CR>]], kb.silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>fq', [[<CMD>lua require('fzf-lua').quickfix()<CR>]], kb.silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>fa', [[<CMD>lua require('fzf-lua').lsp_code_actions()<CR>]], kb.silent_noremap)

vim.api.nvim_set_keymap('n', 'gr', [[<CMD>lua require('fzf-lua').lsp_references()<CR>]], kb.silent_noremap)
vim.api.nvim_set_keymap('n', 'gd', [[<CMD>lua require('fzf-lua').lsp_definitions()<CR>]], kb.silent_noremap)
vim.api.nvim_set_keymap(
  'n',
  '<leader>fb',
  [[<CMD>lua require('fzf-lua').lsp_document_diagnostics()<CR>]],
  kb.silent_noremap
)
vim.api.nvim_set_keymap(
  'n',
  '<leader>fn',
  [[<CMD>lua require('fzf-lua').lsp_workspace_diagnostics()<CR>]],
  kb.silent_noremap
)

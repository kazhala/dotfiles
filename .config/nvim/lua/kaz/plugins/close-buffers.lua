local kb = require('kaz.utils.kb')

require('close_buffers').setup({
  preserve_window_layout = { 'this', 'other' },
  next_buffer_cmd = function(windows)
    require('bufferline').cycle(-1)
    local bufnr = vim.api.nvim_get_current_buf()

    for _, window in ipairs(windows) do
      vim.api.nvim_win_set_buf(window, bufnr)
    end
  end,
})

vim.api.nvim_set_keymap(
  'n',
  '<leader>th',
  [[<CMD>lua require('close_buffers').delete({type = 'hidden'})<CR>]],
  kb.silent_noremap
)
vim.api.nvim_set_keymap(
  'n',
  '<leader>tu',
  [[<CMD>lua require('close_buffers').delete({type = 'nameless'})<CR>]],
  kb.silent_noremap
)
vim.api.nvim_set_keymap(
  'n',
  '<leader>to',
  [[<CMD>lua require('close_buffers').delete({type = 'other'})<CR>]],
  kb.silent_noremap
)
vim.api.nvim_set_keymap(
  'n',
  '<leader>ta',
  [[<CMD>lua require('close_buffers').delete({type = 'all'})<CR>]],
  kb.silent_noremap
)
vim.api.nvim_set_keymap(
  'n',
  '<leader>tc',
  [[<CMD>lua require('close_buffers').delete({type = 'this'})<CR>]],
  kb.silent_noremap
)

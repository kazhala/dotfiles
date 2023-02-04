local close_buffers = require('close_buffers')

close_buffers.setup({
  preserve_window_layout = { 'this', 'other' },
  next_buffer_cmd = function(windows)
    require('bufferline').cycle(-1)
    local bufnr = vim.api.nvim_get_current_buf()

    for _, window in ipairs(windows) do
      vim.api.nvim_win_set_buf(window, bufnr)
    end
  end,
})

vim.keymap.set('n', '<leader>th', function()
  close_buffers.delete({ type = 'hidden' })
  vim.cmd([[redraw!]])
end)
vim.keymap.set('n', '<leader>tu', function()
  close_buffers.delete({ type = 'nameless' })
  vim.cmd([[redraw!]])
end)
vim.keymap.set('n', '<leader>to', function()
  close_buffers.delete({ type = 'other' })
  vim.cmd([[redraw!]])
end)
vim.keymap.set('n', '<leader>ta', function()
  close_buffers.delete({ type = 'all' })
  vim.cmd([[redraw!]])
end)
vim.keymap.set('n', '<leader>tc', function()
  close_buffers.delete({ type = 'this' })
end)

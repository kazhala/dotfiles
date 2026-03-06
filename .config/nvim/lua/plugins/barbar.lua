return {
  'romgrk/barbar.nvim',
  event = 'BufReadPre',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('barbar').setup({
      exclude_ft = { 'qf' },
      icons = {
        button = false,
        diagnostics = {
          [vim.diagnostic.severity.ERROR] = { enabled = true },
          [vim.diagnostic.severity.WARN] = { enabled = true },
          [vim.diagnostic.severity.INFO] = { enabled = false },
          [vim.diagnostic.severity.HINT] = { enabled = false },
        },
      },
    })

    local function close_nameless_buffers()
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_name(buf) == '' then
          vim.api.nvim_buf_delete(buf, {})
        end
      end
    end

    local function close_hidden_buffers()
      local visible = {}
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        visible[vim.api.nvim_win_get_buf(win)] = true
      end
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) and not visible[buf] and vim.bo[buf].buftype == '' then
          vim.api.nvim_buf_delete(buf, {})
        end
      end
    end

    vim.keymap.set('n', '<S-l>', '<CMD>BufferNext<CR>', { silent = true, desc = 'Next buffer' })
    vim.keymap.set('n', '<S-h>', '<CMD>BufferPrevious<CR>', { silent = true, desc = 'Prev buffer' })
    vim.keymap.set('n', ']b', '<CMD>BufferMoveNext<CR>', { silent = true, desc = 'Move buffer right' })
    vim.keymap.set('n', '[b', '<CMD>BufferMovePrevious<CR>', { silent = true, desc = 'Move buffer left' })
    vim.keymap.set('n', '<leader>ts', '<CMD>BufferPickDelete<CR>', { silent = true, desc = 'Pick buffer to close' })
    vim.keymap.set(
      'n',
      '<leader>to',
      '<CMD>BufferCloseAllButCurrent<CR>',
      { silent = true, desc = 'Close other buffers' }
    )
    vim.keymap.set('n', '<leader>ta', '<CMD>BufferCloseAll<CR>', { silent = true, desc = 'Close all buffers' })
    vim.keymap.set('n', '<leader>tc', '<CMD>BufferClose<CR>', { silent = true, desc = 'Close buffer' })
    vim.keymap.set('n', '<leader>th', close_hidden_buffers, { silent = true, desc = 'Close hidden buffers' })
    vim.keymap.set('n', '<leader>tu', close_nameless_buffers, { silent = true, desc = 'Close nameless buffers' })
    vim.keymap.set('n', 'gs', '<CMD>BufferOrderByDirectory<CR>', { silent = true, desc = 'Sort buffers by directory' })
  end,
}

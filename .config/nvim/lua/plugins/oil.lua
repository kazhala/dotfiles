local current_dir = nil

local function open()
  local prev_buf = vim.api.nvim_get_current_buf()
  require('oil').open_float(current_dir)

  -- on fresh startup there is exactly one listed buffer: the initial empty one.
  -- oil opens the selected file in a new buffer and hides the empty one rather
  -- than reusing it (unlike fzf which does :edit in-place). wipe it so it
  -- doesn't linger. guard with the single-buffer check to avoid touching any
  -- unnamed buffers the user intentionally created later.
  if #vim.fn.getbufinfo({ buflisted = 1 }) == 1
    and vim.api.nvim_buf_get_name(prev_buf) == ''
    and not vim.bo[prev_buf].modified
    and vim.bo[prev_buf].buftype == ''
  then
    vim.api.nvim_create_autocmd('BufHidden', {
      buffer = prev_buf,
      once = true,
      callback = vim.schedule_wrap(function()
        if vim.api.nvim_buf_is_valid(prev_buf) then
          pcall(vim.api.nvim_buf_delete, prev_buf, {})
        end
      end),
    })
  end
end

local function hide()
  local oil = require('oil')
  current_dir = oil.get_current_dir()
  oil.close()
end

local function close()
  current_dir = nil
  require('oil').close()
end

return {
  'stevearc/oil.nvim',
  lazy = false,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    { '<C-b>', open, desc = 'Open oil' },
  },
  config = function()
    require('oil').setup({
      columns = { 'icon', 'permissions' },
      float = { border = vim.g.floating_window_border },
      keymaps = {
        ['<C-b>'] = hide,
        ['<C-c>'] = close,
      },
    })
  end,
}

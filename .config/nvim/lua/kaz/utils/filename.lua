local github = require('kaz.utils.github')

local M = {}

function M.copy(relative)
  vim.validate({
    relative = { relative, 'boolean', true },
  })
  relative = relative or false
  local filename
  if not relative then
    filename = vim.api.nvim_buf_get_name(0)
  else
    filename = github.relative_git_filename()
  end
  vim.fn.setreg('*', filename)
  print('Copied ' .. filename .. ' to register *')
end

return M

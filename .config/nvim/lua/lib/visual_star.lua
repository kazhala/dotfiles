local M = {}

function M.star()
  local start_pos = vim.fn.getpos('v')
  local end_pos = vim.fn.getpos('.')
  local s_row, s_col = start_pos[2], start_pos[3]
  local e_row, e_col = end_pos[2], end_pos[3]
  if s_row > e_row or (s_row == e_row and s_col > e_col) then
    start_pos, end_pos = end_pos, start_pos
  end
  local lines = vim.fn.getregion(start_pos, end_pos, { type = 'v' })
  local text = table.concat(lines, '\n')
  vim.fn.setreg('/', [[\V]] .. string.gsub(vim.fn.escape(text, [[/\]]), '\n', '\\n'))
end

return M

local M = {}

function M.star()
  local temp = vim.fn.getreg('s')
  vim.cmd([[norm! gv"sy]])
  vim.fn.setreg('/', [[\V]] .. string.gsub(vim.fn.escape(vim.fn.getreg('s'), [[/\]]), '\n', '\\n'))
  vim.fn.setreg('s', temp)
end

return M

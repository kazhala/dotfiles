local M = {}

function M.buf_set_keymap(...)
  local bufnr = vim.fn.bufnr()
  vim.api.nvim_buf_set_keymap(bufnr, ...)
end

function M.map_missing(mode, lhs, rhs, opts)
  if vim.fn.mapcheck(lhs) == '' then
    vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
  end
end

M.silent_noremap = { noremap = true, silent = true }
M.noremap = { noremap = true }
M.expr_noremap = { noremap = true, expr = true }
M.silent_expr_noremap = { noremap = true, expr = true, silent = true }

return M

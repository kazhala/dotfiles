local M = {}

function M.buf_set_keymap(mode, lhs, rhs, opts)
  local bufnr = vim.fn.bufnr()
  opts = vim.tbl_extend('force', opts, { buffer = bufnr })
  vim.keymap.set(mode, lhs, rhs, opts)
end

function M.map_missing(mode, lhs, rhs, opts)
  if vim.fn.mapcheck(lhs) == '' then
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

M.silent_noremap = { noremap = true, silent = true }
M.noremap = { noremap = true }
M.expr_noremap = { noremap = true, expr = true }
M.silent_expr_noremap = { noremap = true, expr = true, silent = true }

return M

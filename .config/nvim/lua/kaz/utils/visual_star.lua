local M = {}

M.star = function()
  local temp = vim.fn.getreg('s')
  vim.cmd([[norm! gv"sy]])
  vim.fn.setreg('/', [[\V]] .. string.gsub(vim.fn.escape(vim.fn.getreg('s'), [[/\]]), '\n', '\\n'))
  vim.fn.setreg('s', temp)
  print(vim.fn.getreg('/'))
end

vim.cmd([[
xnoremap * :<C-u>lua require('kaz.utils.visual_star').star()<CR>/<C-R>=@/<CR><CR>
xnoremap <leader>rs :<C-u>lua require('kaz.utils.visual_star').star()<CR>/<C-R>=@/<CR><CR>Ncgn
]])

return M

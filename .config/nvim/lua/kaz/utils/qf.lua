local M = {}

function M.qf_open()
  local qf_open = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win['quickfix'] == 1 then
      qf_open = true
    end
  end
  return qf_open
end

function M.toggle_qf()
  local qf_open = M.qf_open()
  if qf_open == true then
    vim.cmd('cclose')
    return
  end
  if not vim.tbl_isempty(vim.fn.getqflist()) then
    vim.cmd('copen')
  end
end

return M

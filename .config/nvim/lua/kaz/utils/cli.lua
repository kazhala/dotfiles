local M = {}

function M.exec(command)
  local f = io.popen(command)
  local l = f:read('*a')
  f:close()
  return l
end

return M

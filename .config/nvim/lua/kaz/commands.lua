vim.cmd([[
command! -nargs=1 Unload lua require('kaz.utils.unload').run(<q-args>)
command! -nargs=1 UnloadAuto lua require('kaz.utils.unload').on_save(<q-args>)
command! PyUtest !python -m unittest %:p
command! PyTest !pytest %:p
]])

local function get_put_objects(...)
  local objects = {}

  for i = 1, select('#', ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  return objects
end

function _G.put(...)
  local objects = get_put_objects(...)
  print(table.concat(objects, '\n'))
  return ...
end

function _G.put_text(...)
  local objects = get_put_objects(...)

  local lines = vim.split(table.concat(objects, '\n'), '\n')
  local lnum = vim.api.nvim_win_get_cursor(0)[1]
  vim.fn.append(lnum, lines)
  return ...
end

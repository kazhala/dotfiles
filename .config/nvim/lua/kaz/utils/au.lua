-- source: https://github.com/vheon/ycm.nvim/blob/master/lua/ycm/autocmd.lua
local M = {}

M._callbacks = {}

local function lua_call(callback)
  local callback_key = tostring(callback)
  M._callbacks[callback_key] = callback
  return string.format("lua require('kaz.utils.au')._callbacks['%s']()", callback_key)
end

function M.augroup(group, au_specs, buffer)
  if group == nil or string.len(group) == 0 then
    return
  end

  vim.cmd([[augroup ]] .. group)

  if buffer == true then
    vim.cmd([[autocmd! * <buffer>]])
  else
    vim.cmd([[autocmd!]])
  end

  if au_specs ~= nil then
    for _, spec in ipairs(au_specs) do
      M.autocmd(spec)
    end
  end
  vim.cmd([[augroup END]])
end

function M.autocmd(cmd_spec)
  local event = cmd_spec.event or ''
  local pattern = cmd_spec.pattern or '*'
  local action = cmd_spec.command or ''
  local callback = cmd_spec.callback

  if type(event) == 'table' then
    event = table.concat(event, ',')
  end
  if string.len(event) == 0 then
    return
  end

  if callback ~= nil then
    action = lua_call(callback)
  end
  if string.len(action) == 0 then
    return
  end

  vim.cmd([[autocmd]] .. ' ' .. event .. ' ' .. pattern .. ' ' .. action)
end

return M

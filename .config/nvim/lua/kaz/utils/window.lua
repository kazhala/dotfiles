local M = {}

local directions = {
  right = 2,
  left = 2,
  down = 1,
  up = 1,
}

local reverse_directions = {
  right = 1,
  left = 1,
  down = 2,
  up = 2,
}

-- Consistant window resize.
---@param direction string Which direction to resize the window.
---@param step number Values to resize.
function M.resize(direction, step)
  vim.validate({
    direction = { direction, 'string' },
    step = { step, 'number', true },
  })

  if directions[direction] == nil then
    return
  end

  local windows = vim.tbl_filter(function(win)
    return vim.api.nvim_get_current_win() ~= win
  end, vim.api.nvim_list_wins())

  local cur_position = vim.api.nvim_win_get_position(0)

  local position
  local is_boundary = true
  local count = 0

  for _, win in ipairs(windows) do
    position = vim.api.nvim_win_get_position(win)
    if
      position[directions[direction]] > cur_position[directions[direction]]
      and position[reverse_directions[direction]] == cur_position[reverse_directions[direction]]
    then
      is_boundary = false
    elseif position[reverse_directions[direction]] == cur_position[reverse_directions[direction]] then
      count = count + 1
    end
  end
  if is_boundary and count == 0 then
    is_boundary = false
  end

  step = step or 1
  if direction == 'left' then
    vim.cmd([[vertical resize ]] .. (is_boundary and '+' or '-') .. step)
  elseif direction == 'right' then
    vim.cmd([[vertical resize ]] .. (is_boundary and '-' or '+') .. step)
  elseif direction == 'down' then
    vim.cmd([[resize]] .. (is_boundary and '-' or '+') .. step)
  elseif direction == 'up' then
    vim.cmd([[resize]] .. (is_boundary and '+' or '-') .. step)
  end
end

return M

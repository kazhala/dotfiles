local kb = require('kaz.utils.kb')
local au = require('kaz.utils.au')

local M = {}

local term_horizontal_ratio = 0.35

function M.resize()
  vim.cmd([[resize ]] .. vim.o.lines * term_horizontal_ratio)
end

require('toggleterm').setup({
  size = function(term)
    if term.direction == 'horizontal' then
      return vim.o.lines * term_horizontal_ratio
    end
  end,
  direction = 'horizontal',
  open_mapping = [[<C-f>]],
})

au.augroup('ResizeTerm', {
  {
    event = 'TermEnter',
    patterm = [[term://*toggleterm#*]],
    callback = function()
      kb.buf_set_keymap('n', '<C-w>=', [[<CMD>lua require('kaz.plugins.toggleterm').resize()<CR>]], kb.silent_noremap)
    end,
  },
})

return M

local kb = require('kaz.utils.kb')
local colors = require('nordbuddy.palette')

require('bufferline').setup({
  highlights = {
    fill = { guibg = colors.bright_black },
    buffer_selected = { gui = 'bold' },
    diagnostic_selected = { gui = 'bold' },
    info_selected = { gui = 'bold' },
    info_diagnostic_selected = { gui = 'bold' },
    warning_selected = { gui = 'bold' },
    warning_diagnostic_selected = { gui = 'bold' },
    error_selected = { gui = 'bold' },
    error_diagnostic_selected = { gui = 'bold' },
  },
  options = {
    show_close_icon = false,
    diagnostics = 'nvim_lsp',
    max_prefix_length = 8,
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      if context.buffer:current() then
        return ''
      end
      if level:match('error') then
        return ' ' .. vim.g.diagnostic_icons.Error
      elseif level:match('warning') then
        return ' ' .. vim.g.diagnostic_icons.Warning
      end
      return ''
    end,
  },
})

vim.api.nvim_set_keymap('n', 'gb', '<CMD>BufferLinePick<CR>', kb.silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>ts', '<CMD>BufferLinePickClose<CR>', kb.silent_noremap)
vim.api.nvim_set_keymap('n', '<S-l>', '<CMD>BufferLineCycleNext<CR>', kb.silent_noremap)
vim.api.nvim_set_keymap('n', '<S-h>', '<CMD>BufferLineCyclePrev<CR>', kb.silent_noremap)
vim.api.nvim_set_keymap('n', ']b', '<CMD>BufferLineMoveNext<CR>', kb.silent_noremap)
vim.api.nvim_set_keymap('n', '[b', '<CMD>BufferLineMovePrev<CR>', kb.silent_noremap)
vim.api.nvim_set_keymap('n', 'gs', '<CMD>BufferLineSortByDirectory<CR>', kb.silent_noremap)

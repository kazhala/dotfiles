require('kaz.utils.au').augroup('IndentRefresh', {
  {
    event = 'CursorMoved',
    pattern = '*',
    callback = function()
      require('indent_blankline').refresh()
    end,
  },
})

vim.g.indent_blankline_show_current_context = true
vim.g.indent_blankline_show_first_indent_level = false
vim.g.indent_blankline_filetype_exclude = {
  'packer',
  'markdown',
  'help',
  'TelescopePrompt',
  'Trouble',
  '',
}
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_context_highlight_list = { 'Keyword' }
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.wo.colorcolumn = '99999'

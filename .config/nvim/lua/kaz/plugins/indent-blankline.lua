require('indent_blankline').setup({
  show_current_context = true,
  show_first_indent_level = false,
  filetype_exclude = {
    'packer',
    'markdown',
    'help',
    'TelescopePrompt',
    'Trouble',
    '',
  },
  buftype_exclude = { 'terminal', 'nofile' },
  context_highlight_list = { 'Keyword' },
  show_trailing_blankline_indent = false,
})

vim.wo.colorcolumn = '99999'

return {
  'numToStr/Navigator.nvim',
  keys = {
    { '<C-h>', '<cmd>NavigatorLeft<cr>',  mode = { 'n', 't' } },
    { '<C-j>', '<cmd>NavigatorDown<cr>',  mode = { 'n', 't' } },
    { '<C-k>', '<cmd>NavigatorUp<cr>',    mode = { 'n', 't' } },
    { '<C-l>', '<cmd>NavigatorRight<cr>', mode = { 'n', 't' } },
  },
  config = function()
    require('Navigator').setup({ disable_on_zoom = true })
  end,
}

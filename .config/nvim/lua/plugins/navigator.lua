return {
  'numToStr/Navigator.nvim',
  lazy = false,
  config = function()
    require('Navigator').setup({ disable_on_zoom = true })

    local map = vim.keymap.set
    map({ 'n', 't' }, '<C-h>', '<cmd>NavigatorLeft<cr>')
    map({ 'n', 't' }, '<C-j>', '<cmd>NavigatorDown<cr>')
    map({ 'n', 't' }, '<C-k>', '<cmd>NavigatorUp<cr>')
    map({ 'n', 't' }, '<C-l>', '<cmd>NavigatorRight<cr>')
  end,
}

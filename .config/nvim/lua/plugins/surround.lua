return {
  'kylechui/nvim-surround',
  keys = { 'ys', 'ds', 'cs', { 'S', mode = 'v' } },
  config = function()
    require('nvim-surround').setup()
  end,
}

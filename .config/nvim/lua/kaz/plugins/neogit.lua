local kb = require('kaz.utils.kb')

require('neogit').setup({
  mappings = {
    status = {
      ['r'] = '',
    },
  },
})

vim.api.nvim_set_keymap('n', '<leader>gs', '<CMD>Neogit kind=split<CR>', kb.noremap)

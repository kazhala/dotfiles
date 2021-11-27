local kb = require('kaz.utils.kb')

require('zen-mode').setup({})

vim.api.nvim_set_keymap('n', '<C-t>', [[<CMD>ZenMode<CR>]], kb.silent_noremap)

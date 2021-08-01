local kb = require('kaz.utils.kb')

require('hop').setup({ jump_on_sole_occurrence = false })

vim.api.nvim_set_keymap('n', 'r', ':HopChar2<CR>', kb.noremap)
vim.api.nvim_set_keymap('n', 'R', ':HopChar1<CR>', kb.noremap)

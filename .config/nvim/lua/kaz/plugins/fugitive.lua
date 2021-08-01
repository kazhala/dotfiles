local kb = require('kaz.utils.kb')

vim.api.nvim_set_keymap('n', '<leader>gs', '<CMD>G<CR>', kb.noremap)
vim.api.nvim_set_keymap('n', '<leader>gq', '<CMD>G<CR><CMD>q<CR>', kb.noremap)
vim.api.nvim_set_keymap('n', '<leader>gw', '<CMD>Gwrite<CR>', kb.noremap)
vim.api.nvim_set_keymap('n', '<leader>gr', '<CMD>Gread<CR>', kb.noremap)
vim.api.nvim_set_keymap('n', '<leader>gh', '<CMD>diffget //2<CR>', kb.noremap)
vim.api.nvim_set_keymap('n', '<leader>gl', '<CMD>diffget //3<CR>', kb.noremap)
vim.api.nvim_set_keymap('n', '<leader>gp', '<CMD>Git push<CR>', kb.noremap)

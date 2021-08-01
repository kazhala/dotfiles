local kb = require('kaz.utils.kb')

require('Navigator').setup({ disable_on_zoom = true })

vim.api.nvim_set_keymap('n', '<C-h>', "<CMD>lua require('Navigator').left()<CR>", kb.silent_noremap)
vim.api.nvim_set_keymap('n', '<C-k>', "<CMD>lua require('Navigator').up()<CR>", kb.silent_noremap)
vim.api.nvim_set_keymap('n', '<C-l>', "<CMD>lua require('Navigator').right()<CR>", kb.silent_noremap)
vim.api.nvim_set_keymap('n', '<C-j>', "<CMD>lua require('Navigator').down()<CR>", kb.silent_noremap)

vim.api.nvim_set_keymap('t', '<C-h>', "<CMD>lua require('Navigator').left()<CR>", kb.silent_noremap)
vim.api.nvim_set_keymap('t', '<C-k>', "<CMD>lua require('Navigator').up()<CR>", kb.silent_noremap)
vim.api.nvim_set_keymap('t', '<C-l>', "<CMD>lua require('Navigator').right()<CR>", kb.silent_noremap)
vim.api.nvim_set_keymap('t', '<C-j>', "<CMD>lua require('Navigator').down()<CR>", kb.silent_noremap)

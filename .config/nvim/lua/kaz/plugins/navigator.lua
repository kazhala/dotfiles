local kb = require('kaz.utils.kb')

require('Navigator').setup({ disable_on_zoom = true })

vim.keymap.set({ 'n', 't' }, '<C-h>', "<CMD>lua require('Navigator').left()<CR>")
vim.keymap.set({ 'n', 't' }, '<C-k>', "<CMD>lua require('Navigator').up()<CR>")
vim.keymap.set({ 'n', 't' }, '<C-l>', "<CMD>lua require('Navigator').right()<CR>")
vim.keymap.set({ 'n', 't' }, '<C-j>', "<CMD>lua require('Navigator').down()<CR>")

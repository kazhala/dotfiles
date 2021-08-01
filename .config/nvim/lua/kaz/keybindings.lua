local kb = require('kaz.utils.kb')

vim.g.mapleader = ' '

kb.map_missing('n', 'Q', 'q', kb.noremap)
kb.map_missing('n', '<S-l>', ':bn<CR>', kb.silent_noremap)
kb.map_missing('n', '<S-h>', ':bp<CR>', kb.silent_noremap)

vim.api.nvim_set_keymap('', 'Y', 'y$', {})
vim.api.nvim_set_keymap('v', 'Y', '"*y', {})
vim.api.nvim_set_keymap('n', 'n', 'nzz', kb.noremap)
vim.api.nvim_set_keymap('n', 'N', 'Nzz', kb.noremap)
vim.api.nvim_set_keymap('n', '<leader>n', '<CMD>noh<CR>', kb.silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>p', '<CMD>set paste!<CR>', kb.noremap)
vim.api.nvim_set_keymap('n', '<C-]>', '<C-^>', kb.noremap)
vim.api.nvim_set_keymap('n', 'gV', '`[v`]', kb.noremap)
vim.api.nvim_set_keymap('v', 'J', ":m '>+1<CR>gv=gv", kb.silent_noremap)
vim.api.nvim_set_keymap('v', 'K', ":m '<-2<CR>gv=gv", kb.silent_noremap)
vim.api.nvim_set_keymap('n', '<C-e>', '3<C-e>', kb.noremap)
vim.api.nvim_set_keymap('n', '<C-y>', '3<C-y>', kb.noremap)
vim.api.nvim_set_keymap('n', '<UP>', '<C-W>3+', kb.noremap)
vim.api.nvim_set_keymap('n', '<Down>', '<C-W>3-', kb.noremap)
vim.api.nvim_set_keymap('n', '<Right>', '<C-W>3>', kb.noremap)
vim.api.nvim_set_keymap('n', '<Left>', '<C-W>3<', kb.noremap)

vim.api.nvim_set_keymap('x', '*', ":<C-u>lua require('kaz.utils.visual_star').star()<CR>/<C-R>=@/<CR><CR>", kb.noremap)
vim.api.nvim_set_keymap(
  'x',
  '<leader>rs',
  ":<C-u>lua require('kaz.utils.visual_star').star()<CR>/<C-R>=@/<CR><CR>Ncgn",
  kb.noremap
)
vim.api.nvim_set_keymap('n', '<leader>rs', '*Ncgn', kb.noremap)
vim.api.nvim_set_keymap('n', 'k', [[(v:count > 1 ? "m'" . v:count : '') . 'k']], kb.expr_noremap)
vim.api.nvim_set_keymap('n', 'j', [[(v:count > 1 ? "m'" . v:count : '') . 'j']], kb.expr_noremap)
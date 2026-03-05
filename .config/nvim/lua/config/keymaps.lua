vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

local window = require('lib.window')
local visual_star = require('lib.visual_star')
local codelink = require('lib.codelink')

vim.keymap.set('n', 'Q', 'q', { noremap = true })

vim.keymap.set('v', 'Y', '"*y')
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', '<leader>n', '<CMD>noh<CR>', { silent = true })
vim.keymap.set('n', '<C-]>', '<C-^>')
vim.keymap.set('n', 'gV', '`[v`]')
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set('n', '<C-e>', '3<C-e>')
vim.keymap.set('n', '<C-y>', '3<C-y>')

-- visual star search
vim.keymap.set('x', '*', function()
  visual_star.star()
  vim.cmd('/' .. vim.fn.getreg('/'))
end)
vim.keymap.set('x', '<leader>rs', function()
  visual_star.star()
  vim.cmd('/' .. vim.fn.getreg('/'))
  vim.cmd('normal! Ncgn')
end)
vim.keymap.set('n', '<leader>rs', '*Ncgn')

-- jump large counts to jumplist
vim.keymap.set('n', 'k', [[(v:count > 1 ? "m'" . v:count : '') . 'k']], { expr = true })
vim.keymap.set('n', 'j', [[(v:count > 1 ? "m'" . v:count : '') . 'j']], { expr = true })

-- window resize
vim.keymap.set('n', '<M-k>', function() window.resize('up', 2) end)
vim.keymap.set('n', '<M-j>', function() window.resize('down', 2) end)
vim.keymap.set('n', '<M-l>', function() window.resize('right', 2) end)
vim.keymap.set('n', '<M-h>', function() window.resize('left', 2) end)

-- codelink
vim.keymap.set('n', '<leader>go', function() codelink.open({ platform = 'github', line = true }) end)
vim.keymap.set('n', '<leader>gb', function() codelink.open({ platform = 'github', branch = vim.fn.input('Branch: ', '') }) end)
vim.keymap.set('n', '<leader>gs', function() codelink.open({ platform = 'sourcegraph', line = true }) end)
vim.keymap.set('n', '<leader>gc', function() codelink.copy_filename({ relative = true }) end)

-- LSP
vim.keymap.set('n', 'K',          function() vim.lsp.buf.hover({ border = vim.g.floating_window_border }) end, { silent = true, desc = 'Hover' })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename,                                                          { silent = true, desc = 'Rename' })
vim.keymap.set('n', '<leader>ce', '<cmd>LspRestart<cr>',                                                       { silent = true, desc = 'Restart LSP' })
vim.keymap.set('n', ']g',         function() vim.diagnostic.jump({ count = 1 }) end,                           { silent = true, desc = 'Next diagnostic' })
vim.keymap.set('n', '[g',         function() vim.diagnostic.jump({ count = -1 }) end,                          { silent = true, desc = 'Prev diagnostic' })

-- TODO: <leader>dd → trouble.nvim TroubleToggle

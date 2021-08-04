local kb = require('kaz.utils.kb')

require('gitsigns').setup({
  signs = {
    add = { hl = 'GitSignsAdd', text = '┃' },
    change = { hl = 'GitSignsChange', text = '┃' },
    delete = { hl = 'GitSignsDelete', text = '┃' },
    topdelete = { hl = 'GitSignsDelete', text = '┃' },
    changedelete = { hl = 'GitSignsChange', text = '┃' },
  },
  keymaps = {
    noremap = true,
    ['n ]h'] = {
      expr = true,
      "&diff ? ']c' : '<CMD>lua require(\"gitsigns.actions\").next_hunk()<CR>'",
    },
    ['n [h'] = {
      expr = true,
      "&diff ? '[c' : '<CMD>lua require(\"gitsigns.actions\").prev_hunk()<CR>'",
    },

    ['n <leader>hs'] = '<CMD>lua require("gitsigns").stage_hunk()<CR>',
    ['v <leader>hs'] = '<CMD>lua require("gitsigns").stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <leader>hu'] = '<CMD>lua require("gitsigns").undo_stage_hunk()<CR>',
    ['n <leader>hr'] = '<CMD>lua require("gitsigns").reset_hunk()<CR>',
    ['v <leader>hr'] = '<CMD>lua require("gitsigns").reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <leader>hR'] = '<CMD>lua require("gitsigns").reset_buffer()<CR>',
    ['n <leader>hp'] = '<CMD>lua require("gitsigns").preview_hunk()<CR>',
    ['n <leader>hb'] = '<CMD>lua require("gitsigns").blame_line(true)<CR>',
    ['n <leader>hh'] = '<CMD>lua require("gitsigns").refresh()<CR>',

    ['o ih'] = ':<C-U>lua require("gitsigns.actions").select_hunk()<CR>',
    ['x ih'] = ':<C-U>lua require("gitsigns.actions").select_hunk()<CR>',
  },
})

vim.api.nvim_set_keymap('n', '<leader>hh', '<CMD>lua require("gitsigns").refresh()<CR>', kb.silent_noremap)

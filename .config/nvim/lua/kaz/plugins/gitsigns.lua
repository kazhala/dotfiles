local kb = require('kaz.utils.kb')

require('gitsigns').setup({
  signs = {
    add = { hl = 'GitSignsAdd', text = '┃' },
    change = { hl = 'GitSignsChange', text = '┃' },
    delete = { hl = 'GitSignsDelete', text = '┃' },
    topdelete = { hl = 'GitSignsDelete', text = '┃' },
    changedelete = { hl = 'GitSignsChange', text = '┃' },
  },
  on_attach = function(bufnr)
    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    buf_set_keymap('n', ']h', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", kb.expr_noremap)
    buf_set_keymap('n', '[h', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", kb.expr_noremap)

    buf_set_keymap('n', '<leader>hs', '<CMD>lua require("gitsigns").stage_hunk()<CR>', kb.silent_noremap)
    buf_set_keymap(
      'v',
      '<leader>hs',
      '<CMD>lua require("gitsigns").stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
      kb.silent_noremap
    )
    buf_set_keymap('n', '<leader>hu', '<CMD>lua require("gitsigns").undo_stage_hunk()<CR>', kb.silent_noremap)
    buf_set_keymap('n', '<leader>hr', '<CMD>lua require("gitsigns").reset_hunk()<CR>', kb.silent_noremap)
    buf_set_keymap(
      'v',
      '<leader>hr',
      '<CMD>lua require("gitsigns").reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
      kb.silent_noremap
    )
    buf_set_keymap('n', '<leader>hR', '<CMD>lua require("gitsigns").reset_buffer()<CR>', kb.silent_noremap)
    buf_set_keymap('n', '<leader>hp', '<CMD>lua require("gitsigns").preview_hunk()<CR>', kb.silent_noremap)
    buf_set_keymap('n', '<leader>hb', '<CMD>lua require("gitsigns").blame_line(true)<CR>', kb.silent_noremap)
    buf_set_keymap('n', '<leader>hh', '<CMD>lua require("gitsigns").refresh()<CR>', kb.silent_noremap)
    buf_set_keymap('o', 'ih', ':<C-U>lua require("gitsigns.actions").select_hunk()<CR>', kb.silent_noremap)
    buf_set_keymap('x', 'ih', ':<C-U>lua require("gitsigns.actions").select_hunk()<CR>', kb.silent_noremap)
  end,
})

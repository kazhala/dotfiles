return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local gs = require('gitsigns')

    gs.setup({
      signs = {
        add = { text = '┃' },
        change = { text = '┃' },
        delete = { text = '┃' },
        topdelete = { text = '┃' },
        changedelete = { text = '┃' },
      },
      preview_config = {
        border = vim.g.floating_window_border,
      },
    })

    vim.keymap.set('n', ']h', function()
      if vim.wo.diff then
        vim.cmd.normal({ ']c', bang = true })
      else
        gs.nav_hunk('next')
      end
    end)
    vim.keymap.set('n', '[h', function()
      if vim.wo.diff then
        vim.cmd.normal({ '[c', bang = true })
      else
        gs.nav_hunk('prev')
      end
    end)

    vim.keymap.set({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>')
    vim.keymap.set({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>')
    vim.keymap.set('n', '<leader>hu', gs.undo_stage_hunk)
    vim.keymap.set('n', '<leader>hR', gs.reset_buffer)
    vim.keymap.set('n', '<leader>hp', gs.preview_hunk)
    vim.keymap.set('n', '<leader>hh', gs.refresh)

    vim.keymap.set({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end,
}

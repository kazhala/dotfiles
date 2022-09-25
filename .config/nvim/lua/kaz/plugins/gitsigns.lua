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
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    map('n', ']h', function()
      if vim.wo.diff then
        return ']h'
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return '<Ignore>'
    end, { expr = true })
    map('n', '[h', function()
      if vim.wo.diff then
        return '[h'
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return '<Ignore>'
    end, { expr = true })

    map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>')
    map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>hR', gs.reset_buffer)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hh', gs.refresh)

    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end,
})

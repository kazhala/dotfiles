return {
  'echasnovski/mini.pairs',
  event = 'InsertEnter',
  config = function()
    require('mini.pairs').setup({
      mappings = {
        -- don't auto-close when the character to the right is a word character
        ['('] = { action = 'open',      pair = '()', neigh_pattern = '.[^%w]' },
        ['['] = { action = 'open',      pair = '[]', neigh_pattern = '.[^%w]' },
        ['{'] = { action = 'open',      pair = '{}', neigh_pattern = '.[^%w]' },
        ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^\\][^%w]', register = { cr = false } },
        ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '[^%a\\][^%w]', register = { cr = false } },
        ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^\\][^%w]', register = { cr = false } },
      },
    })
  end,
}

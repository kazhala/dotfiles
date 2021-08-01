local ls = require('luasnip')

ls.snippets = {
  lua = {
    ls.snippet('ds', {
      ls.text_node('--- '),
      ls.insert_node(1, 'Descriptions'),
      ls.text_node('.'),
    }),
    ls.snippet('da', {
      ls.text_node('-- @param '),
      ls.insert_node(1, 'param type'),
      ls.text_node(': '),
      ls.insert_node(2, 'Descriptions'),
      ls.text_node('.'),
    }),
    ls.snippet('dr', {
      ls.text_node('-- @return '),
      ls.insert_node(1, 'type'),
      ls.text_node(': '),
      ls.insert_node(2, 'Descriptions'),
      ls.text_node('.'),
    }),
  },

  python = {
    ls.snippet('ds', {
      ls.text_node('"""'),
      ls.insert_node(1, 'Descriptions'),
      ls.text_node({ '.', '', '' }),
      ls.insert_node(2),
      ls.text_node({ '', '"""' }),
    }),
    ls.snippet('df', {
      ls.text_node('"""'),
      ls.insert_node(1, 'Descriptions'),
      ls.text_node('."""'),
    }),
    ls.snippet('da', {
      ls.text_node(':param '),
      ls.insert_node(1, 'param'),
      ls.text_node(': '),
      ls.insert_node(2, 'Descriptions'),
      ls.text_node('.'),
    }),
    ls.snippet('dr', {
      ls.text_node(':return: '),
      ls.insert_node(1, 'Descriptions'),
      ls.text_node('.'),
    }),
  },
}

vim.api.nvim_set_keymap('i', '<c-l>', '<Plug>luasnip-expand-or-jump', { silent = true })
vim.api.nvim_set_keymap('s', '<c-l>', '<Plug>luasnip-expand-or-jump', { silent = true })
vim.api.nvim_set_keymap('i', '<c-h>', '<Plug>luasnip-jump-prev', { silent = true })
vim.api.nvim_set_keymap('s', '<c-h>', '<Plug>luasnip-jump-prev', { silent = true })

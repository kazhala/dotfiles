return {
  'L3MON4D3/LuaSnip',
  version = 'v2.*',
  event = 'InsertEnter',
  config = function()
    local ls = require('luasnip')

    ls.add_snippets('python', {
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
      ls.snippet('fc', {
        ls.text_node('def __init__(self'),
        ls.insert_node(1),
        ls.text_node({ ') -> None:', '\t' }),
        ls.insert_node(2, 'pass'),
      }),
      ls.snippet('ff', {
        ls.text_node('def '),
        ls.insert_node(1, 'function'),
        ls.text_node('('),
        ls.insert_node(2),
        ls.text_node(')'),
        ls.insert_node(3),
        ls.text_node({ ':', '\t' }),
        ls.insert_node(4, 'pass'),
      }),
    })

    vim.keymap.set({ 'i', 's' }, '<C-l>', '<Plug>luasnip-expand-or-jump')
    vim.keymap.set({ 'i', 's' }, '<C-h>', '<Plug>luasnip-jump-prev')
  end,
}

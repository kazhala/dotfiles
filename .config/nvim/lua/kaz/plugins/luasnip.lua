local ls = require('luasnip')

ls.add_snippets('sh', {
  ls.snippet('dd', {
    ls.text_node('# -- '),
    ls.insert_node(1, ''),
    ls.text_node(' '),
    ls.function_node(function(args, snips, user_arg_1)
      return string.rep('-', 74 - string.len(args[1][1]))
    end, {
      1,
    }, {}),
  }),
}, {
  key = 'sh',
})

ls.add_snippets('lua', {
  ls.snippet('da', {
    ls.text_node('---@param '),
    ls.insert_node(1, 'param type'),
  }),
  ls.snippet('dt', {
    ls.text_node('---@type '),
    ls.insert_node(1, 'type'),
  }),
  ls.snippet('dr', {
    ls.text_node('---@return '),
    ls.insert_node(1, 'type'),
  }),
}, {
  key = 'lua',
})

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
}, {
  key = 'python',
})

vim.keymap.set({ 's', 'i' }, '<c-l>', '<Plug>luasnip-expand-or-jump')
vim.keymap.set({ 's', 'i' }, '<c-h>', '<Plug>luasnip-jump-prev')

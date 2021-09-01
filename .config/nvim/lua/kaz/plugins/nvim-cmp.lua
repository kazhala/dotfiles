local cmp = require('cmp')
local luasnip = require('luasnip')

local completion_menu = {
  nvim_lsp = '[]',
  buffer = '[﬘]',
  path = '[]',
  spell = '[﬜]',
}

local completion_kind = {
  Text = ' (text)',
  Method = ' (method)',
  Function = ' (function)',
  Constructor = ' (constructor)',
  Field = 'ﰠ (field)',
  Variable = ' (variable)',
  Class = ' (class)',
  Interface = ' (interface)',
  Module = ' (module)',
  Property = ' (property)',
  Unit = ' (unit)',
  Value = ' (value)',
  Enum = ' (enum)',
  Key = ' (key)',
  Snippet = '﬌ (snippet)',
  Color = ' (color)',
  File = ' (file)',
  Reference = ' (reference)',
  Folder = ' (folder)',
  EnumMember = ' (enum member)',
  Constant = ' (constant)',
  Struct = ' (struct)',
  Event = ' (event)',
  Operator = ' (operator)',
  TypeParameter = ' (type)',
}

cmp.setup({
  formatting = {
    format = function(entry, vim_item)
      vim_item.menu = completion_menu[entry.source.name]
      vim_item.kind = completion_kind[vim_item.kind]
      vim_item.abbr = string.sub(vim_item.abbr, 1, 30)
      return vim_item
    end,
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<tab>'] = cmp.mapping.select_next_item(),
    ['<S-tab>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-b>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = false,
    }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'buffer' },
    { name = 'spell' },
  },
})

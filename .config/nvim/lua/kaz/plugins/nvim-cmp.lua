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

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

local function tab(fallback)
  if vim.fn.pumvisible() == 1 then
    vim.fn.feedkeys(t('<C-n>'), 'n')
  elseif luasnip.expand_or_jumpable() then
    vim.fn.feedkeys(t('<Plug>luasnip-expand-or-jump'), '')
  elseif check_back_space() then
    vim.fn.feedkeys(t('<tab>'), 'n')
  else
    fallback()
  end
end

local function stab(fallback)
  if vim.fn.pumvisible() == 1 then
    vim.fn.feedkeys(t('<C-p>'), 'n')
  elseif luasnip.jumpable(-1) then
    vim.fn.feedkeys(t('<Plug>luasnip-jump-prev'), '')
  else
    fallback()
  end
end

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
    ['<tab>'] = cmp.mapping(tab, { 'i', 's' }),
    ['<S-tab>'] = cmp.mapping(stab, { 'i', 's' }),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
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

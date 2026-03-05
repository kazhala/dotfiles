return {
  'saghen/blink.cmp',
  event = 'InsertEnter',
  version = '*',
  config = function()
    require('blink.cmp').setup({
      keymap = {
        preset = 'none',
        ['<Tab>'] = { 'select_next', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'fallback' },
        ['<CR>'] = { 'accept', 'fallback' },
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide', 'fallback' },
        ['<C-d>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
      },
      completion = {
        ghost_text = { enabled = false },
        list = { selection = { preselect = false } },
        menu = {
          border = vim.g.floating_window_border,
          draw = {
            columns = {
              { 'label', 'label_description', gap = 1 },
              { 'kind_icon', 'kind', gap = 1 },
            },
          },
        },
        documentation = {
          auto_show = true,
          window = { border = vim.g.floating_window_border },
        },
      },
      signature = {
        enabled = true,
        window = { border = vim.g.floating_window_border },
      },
      sources = {
        default = { 'lsp', 'path', 'buffer' },
      },
    })
  end,
}

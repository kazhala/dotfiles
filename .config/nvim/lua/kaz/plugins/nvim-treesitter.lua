local kb = require('kaz.utils.kb')

require('nvim-treesitter.configs').setup({
  ensure_installed = { 'lua', 'python', 'yaml', 'hcl', 'bash', 'json', 'toml', 'comment', 'markdown' },
  indent = { enable = false },
  highlight = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'gi',
      scope_incremental = 'ga',
      node_decremental = 'gr',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = { [']m'] = '@function.outer', [']]'] = '@class.outer' },
      goto_next_end = { [']M'] = '@function.outer', [']['] = '@class.outer' },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = { ['[M'] = '@function.outer', ['[]'] = '@class.outer' },
    },
    lsp_interop = {
      enable = true,
      border = 'none',
      peek_definition_code = {
        ['gnf'] = '@function.outer',
        ['gnc'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = { [']a'] = '@parameter.inner' },
      swap_previous = { ['[a'] = '@parameter.inner' },
    },
  },
})

vim.api.nvim_set_keymap('n', '<leader>ch', ':write | edit | TSBufEnable highlighting<CR>', kb.silent_noremap)

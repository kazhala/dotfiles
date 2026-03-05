return {
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    build = ':MasonUpdate',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
    config = function()
      require('mason').setup({
        ui = { border = vim.g.floating_window_border },
      })
    end,
  },

  { 'williamboman/mason-lspconfig.nvim' },

  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    config = function()
      require('mason-tool-installer').setup({
        ensure_installed = {
          'stylua',
          'shfmt',
          'prettier',
          'goimports',
        },
      })
    end,
  },
}

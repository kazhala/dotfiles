return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
  },
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    vim.lsp.log.set_level('error')

    -- Auto-install servers
    require('mason-lspconfig').setup({
      ensure_installed = {
        'basedpyright',
        'ruff',
        'lua_ls',
        'terraformls',
        'gopls',
      },
    })

    -- Diagnostic signs in the gutter
    local icons = vim.g.diagnostic_icons
    vim.diagnostic.config({
      virtual_text = false,
      update_in_insert = false,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = icons.Error,
          [vim.diagnostic.severity.WARN] = icons.Warning,
          [vim.diagnostic.severity.INFO] = icons.Information,
          [vim.diagnostic.severity.HINT] = icons.Hint,
        },
        texthl = {
          [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
          [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
          [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
          [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
        },
        numhl = {
          [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
          [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
          [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
          [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
        },
      },
      float = {
        focusable = false,
        border = vim.g.floating_window_border,
        source = 'if_many',
      },
    })

    -- Prefer UTF-8 across all servers (avoids encoding mismatch between e.g. basedpyright and ruff)
    vim.lsp.config('*', {
      capabilities = {
        general = { positionEncodings = { 'utf-8' } },
      },
    })

    -- Server configs
    vim.lsp.config('basedpyright', {
      settings = {
        basedpyright = {
          disableOrganizeImports = true,
        },
      },
    })

    vim.lsp.config('ruff', {
      on_attach = function(client)
        client.server_capabilities.hoverProvider = false
      end,
    })

    vim.lsp.config('lua_ls', {
      settings = {
        Lua = {
          runtime = { version = 'LuaJIT' },
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME,
              '${3rd}/luv/library',
            },
          },
          diagnostics = { globals = { 'vim' }, disable = { 'different-requires', 'duplicate-set-field' } },
          telemetry = { enable = false },
        },
      },
    })

    vim.lsp.enable({ 'basedpyright', 'ruff', 'lua_ls', 'terraformls', 'gopls' })
  end,
}

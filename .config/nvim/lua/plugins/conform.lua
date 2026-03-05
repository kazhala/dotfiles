return {
  'stevearc/conform.nvim',
  dependencies = { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
  event = 'BufWritePre',
  keys = {
    {
      '<leader>cf',
      function()
        require('conform').format({ async = true })
      end,
      desc = 'Format buffer',
    },
  },
  config = function()
    require('conform').setup({
      formatters_by_ft = {
        python = { 'ruff_organize_imports', 'ruff_format' },
        go = { 'goimports' },
        terraform = { 'terraform_fmt' },
        hcl = { 'terraform_fmt' },
        lua = { 'stylua' },
        sh = { 'shfmt' },
        bash = { 'shfmt' },
        json = { 'prettier' },
        jsonc = { 'prettier' },
        yaml = { 'prettier' },
        markdown = { 'prettier' },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = 'fallback',
      },
    })
  end,
}

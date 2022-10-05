local builtins = require('null-ls').builtins
local augroup = vim.api.nvim_create_augroup('LspFormatOnSave', {})

local M = {}

function M.setup()
  require('null-ls').setup({
    sources = {
      builtins.formatting.stylua,
      builtins.formatting.shfmt.with({
        filetype = { 'sh', 'zsh' },
      }),
      builtins.formatting.terraform_fmt.with({
        filetypes = { 'terraform', 'tf', 'hcl' },
      }),
      builtins.formatting.prettier.with({
        filetypes = { 'json', 'yaml', 'markdown' },
      }),
      builtins.formatting.isort,
      builtins.formatting.black,
      builtins.formatting.djhtml.with({
        extra_args = { '-t', '2' },
      }),
      builtins.diagnostics.shellcheck.with({
        diagnostics_format = '#{m} [#{c}]',
      }),
      builtins.code_actions.gitsigns,
    },
    on_attach = function(client, bufnr)
      if client.supports_method('textDocument/formatting') then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = augroup,
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({ bufnr = bufnr })
          end,
        })
      end
    end,
  })
end

return M

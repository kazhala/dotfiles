local builtins = require('null-ls').builtins

local M = {}

function M.setup(on_attach, capabilities)
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
      builtins.diagnostics.shellcheck.with({ diagnostics_format = '#{m} [#{c}]' }),
      builtins.code_actions.gitsigns,
    },
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

return M

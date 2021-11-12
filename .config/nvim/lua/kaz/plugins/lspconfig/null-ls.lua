local builtins = require('null-ls').builtins

local M = {}

function M.setup(on_attach)
  require('null-ls').config({
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
      builtins.diagnostics.shellcheck,
    },
  })

  require('lspconfig')['null-ls'].setup({
    on_attach = on_attach,
  })
end

return M

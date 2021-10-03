local M = {}

local sh_fmt = { formatCommand = 'shfmt -i 2', formatStdin = true }
local prettier_fmt = { formatCommand = 'prettier --stdin-filepath ${INPUT}', formatStdin = true }
local terraform_fmt = { formatCommand = 'terraform fmt -', formatStdin = true }

local efm_languages = {
  lua = { { formatCommand = 'stylua -s -', formatStdin = true } },
  python = {
    { formatCommand = 'black --fast -', formatStdin = true },
    { formatCommand = 'isort -', formatStdin = true },
  },
  hcl = { terraform_fmt },
  terraform = { terraform_fmt },
  sh = {
    sh_fmt,
    {
      lintCommand = 'shellcheck -f gcc -x -',
      lintStdin = true,
      lintFormats = { '%f:%l:%c: %trror: %m', '%f:%l:%c: %tarning: %m', '%f:%l:%c: %tote: %m' },
      lintSource = 'shellcheck',
    },
  },
  zsh = { sh_fmt },
  markdown = { prettier_fmt },
  json = { prettier_fmt },
  yaml = { prettier_fmt },
}

function M.setup(on_attach)
  require('lspconfig').efm.setup({
    on_attach = on_attach,
    init_options = { documentFormatting = true },
    filetypes = vim.tbl_keys(efm_languages),
    settings = { rootMarkers = { '.git/' }, languages = efm_languages },
  })
end

return M

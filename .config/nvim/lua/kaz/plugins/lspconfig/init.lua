local au = require('kaz.utils.au')
local utils = require('kaz.utils.lsp')
local kb = require('kaz.utils.kb')

vim.lsp.protocol.CompletionItemKind = {
  ' (text)',
  ' (method)',
  ' (function)',
  ' (constructor)',
  'ﰠ (field)',
  ' (variable)',
  ' (class)',
  ' (interface)',
  ' (module)',
  ' (property)',
  ' (unit)',
  ' (value)',
  ' (enum)',
  ' (key)',
  '﬌ (snippet)',
  ' (color)',
  ' (file)',
  ' (reference)',
  ' (folder)',
  ' (enum member)',
  ' (constant)',
  ' (struct)',
  ' (event)',
  ' (operator)',
  ' (type)',
}

local signs = {
  Error = vim.g.diagnostic_icons.Error,
  Warn = vim.g.diagnostic_icons.Warning,
  Hint = vim.g.diagnostic_icons.Hint,
  Info = vim.g.diagnostic_icons.Information,
}

for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  { virtual_text = false, update_in_insert = false }
)
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = vim.g.floating_window_border })
vim.lsp.handlers['textDocument/formatting'] = utils.format_async

au.augroup('ShowDiagnostics', {
  {
    event = 'CursorHold,CursorHoldI',
    pattern = '*',
    callback = function()
      vim.diagnostic.open_float(nil, {
        focusable = false,
        border = vim.g.floating_window_border,
        source = 'if_many',
      })
    end,
  },
})

local disabled_signature_lsp = {
  terraformls = true,
  efm = true,
  tflint = true,
  ['null-ls'] = true,
}

local on_attach = function(client, bufnr)
  require('illuminate').on_attach(client)

  if disabled_signature_lsp[client.name] == nil then
    require('lsp_signature').on_attach({
      bind = true,
      hint_enable = false,
      hi_parameter = 'CursorLine',
      handler_opts = { border = 'single' },
    })
  end

  client.server_capabilities.documentFormattingProvider = false

  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  buf_set_keymap('n', 'K', '<CMD>lua require("kaz.utils.lsp").show_documentation()<CR>', kb.silent_noremap)
  buf_set_keymap('n', '<leader>rn', '<CMD>lua vim.lsp.buf.rename()<CR>', kb.silent_noremap)
  buf_set_keymap('n', '<leader>ce', '<CMD>LspRestart<CR>', kb.silent_noremap)
  buf_set_keymap('n', '<leader>cf', '<CMD>lua vim.lsp.buf.formatting_sync()<CR>', kb.silent_noremap)
  buf_set_keymap('n', ']g', '<CMD>lua vim.lsp.diagnostic.goto_next()<CR>', kb.silent_noremap)
  buf_set_keymap('n', '[g', '<CMD>lua vim.lsp.diagnostic.goto_prev()<CR>', kb.silent_noremap)
end

require('kaz.plugins.lspconfig.pyright').setup(on_attach)
require('kaz.plugins.lspconfig.sumneko_lua').setup(on_attach)
require('kaz.plugins.lspconfig.yamlls').setup(on_attach)
require('kaz.plugins.lspconfig.terraformls').setup(on_attach)
require('kaz.plugins.lspconfig.tflint').setup(on_attach)
require('kaz.plugins.lspconfig.bashls').setup(on_attach)
require('kaz.plugins.lspconfig.null-ls').setup()

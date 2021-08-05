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
  ' (enum)',
  ' (key)',
  '﬌ (snippet)',
  ' (color)',
  ' (file)',
  ' (reference)',
  ' (folder)',
  ' (enum member)',
  ' (constant)',
  ' (struct)',
  ' (event)',
  ' (operator)',
  ' (type)',
}

vim.fn.sign_define('LspDiagnosticsSignError', { text = vim.g.diagnostic_icons.Error })
vim.fn.sign_define('LspDiagnosticsSignWarning', { text = vim.g.diagnostic_icons.Warning })
vim.fn.sign_define('LspDiagnosticsSignInformation', { text = vim.g.diagnostic_icons.Information })
vim.fn.sign_define('LspDiagnosticsSignHint', { text = vim.g.diagnostic_icons.Hint })

au.augroup('ShowDiagnostics', {
  {
    event = 'CursorHold',
    pattern = '*',
    callback = function()
      vim.lsp.diagnostic.show_line_diagnostics({
        focusable = false,
        border = vim.g.floating_window_border,
      })
    end,
  },
  {
    event = 'CursorHoldI',
    pattern = '*',
    callback = function()
      vim.lsp.diagnostic.show_line_diagnostics({
        focusable = false,
        border = vim.g.floating_window_border,
      })
    end,
  },
})

local on_attach = function(client, bufnr)
  require('illuminate').on_attach(client)

  if client.name ~= 'terraformls' and client.name ~= 'efm' then
    require('lsp_signature').on_attach({
      bind = true,
      hint_enable = false,
      hi_parameter = 'CursorLine',
      handler_opts = { border = 'single' },
    })
  end

  if client.name ~= 'efm' then
    client.resolved_capabilities.document_formatting = false
  end

  if client.resolved_capabilities.document_formatting then
    au.augroup('LspFormatOnSave', {
      {
        event = 'BufWritePost',
        pattern = [[<buffer>]],
        callback = function()
          vim.lsp.buf.formatting()
        end,
      },
    }, true)
  end

  vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    { virtual_text = false, update_in_insert = false }
  )
  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = vim.g.floating_window_border }
  )
  vim.lsp.handlers['textDocument/formatting'] = utils.format_async

  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local opts = { noremap = true, silent = true }

  buf_set_keymap('n', 'K', '<CMD>lua require("kaz.utils.lsp").show_documentation()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<CMD>lua vim.lsp.buf.rename()<CR>', kb.silent_noremap)
  buf_set_keymap('n', '<leader>ca', '<CMD>lua vim.lsp.buf.code_action()<CR>', kb.silent_noremap)
  buf_set_keymap('n', '<leader>ce', '<CMD>LspRestart<CR>', kb.silent_noremap)
  buf_set_keymap('n', '<leader>cf', '<CMD>lua vim.lsp.buf.formatting_sync()<CR>', kb.silent_noremap)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require('kaz.plugins.lspconfig.pyright').setup(on_attach)
require('kaz.plugins.lspconfig.efm').setup(on_attach)
require('kaz.plugins.lspconfig.sumneko_lua').setup(on_attach)
require('kaz.plugins.lspconfig.yamlls').setup(on_attach)
require('kaz.plugins.lspconfig.terraformls').setup(on_attach, capabilities)
require('kaz.plugins.lspconfig.bashls').setup(on_attach)

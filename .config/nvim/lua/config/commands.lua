-- TODO: add build/test commands for bazel

vim.api.nvim_create_user_command('LspClearLogs', function()
  vim.fn.writefile({}, vim.lsp.get_log_path())
  vim.notify('LSP logs cleared')
end, { desc = 'Clear LSP log file' })

-- debugging: pretty-print lua values to command line
function _G.put(...)
  local objects = {}
  for i = 1, select('#', ...) do
    table.insert(objects, vim.inspect(select(i, ...)))
  end
  print(table.concat(objects, '\n'))
  return ...
end

-- debugging: pretty-print lua values as text below cursor
function _G.put_text(...)
  local objects = {}
  for i = 1, select('#', ...) do
    table.insert(objects, vim.inspect(select(i, ...)))
  end
  local lines = vim.split(table.concat(objects, '\n'), '\n')
  vim.fn.append(vim.api.nvim_win_get_cursor(0)[1], lines)
  return ...
end

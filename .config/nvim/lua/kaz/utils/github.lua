local cli = require('kaz.utils.cli')

local M = {}

local REMOTE = 'https://github.com'

function M.current_file(branch, line)
  vim.validate({
    branch = { branch, 'string', true },
    line = { line, 'boolean', true },
  })
  local filename, remote_pattern, base_url
  local suffix = ''

  branch = branch or cli.exec('git branch --show-current'):gsub('%s+', '')
  line = line or false

  filename = cli.exec('git ls-files --full-name ' .. vim.api.nvim_buf_get_name(0)):gsub('%s+', '')
  remote_pattern = cli.exec('git remote get-url origin')

  if remote_pattern:match(REMOTE) then
    base_url = remote_pattern:match('(.+).git')
  else
    base_url = REMOTE .. '/' .. remote_pattern:match('.*:(.+).git')
  end

  if line then
    suffix = suffix .. '#L' .. vim.api.nvim_win_get_cursor(0)[1]
  end

  if not filename then
    os.execute('open ' .. base_url)
  else
    os.execute('open ' .. base_url .. '/blob/' .. branch .. '/' .. filename .. suffix)
  end
end

return M

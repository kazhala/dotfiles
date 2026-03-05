local M = {}

M.config = {
  sourcegraph_url = 'https://canva.sourcegraphcloud.com',
  sourcegraph_prefix = '/r', -- some instances don't have this, set to '' if so
}

local function git(cmd)
  return vim.fn.system('git ' .. cmd):gsub('%s+', '')
end

local function relative_filename()
  return git('ls-files --full-name ' .. vim.api.nvim_buf_get_name(0))
end

local function parse_repo(remote)
  -- handles both SSH (git@github.com:org/repo.git) and HTTPS (https://github.com/org/repo.git)
  return remote:match('github%.com[:/](.-)%.git') or remote:match('github%.com/(.+)')
end

function M.copy_filename(opts)
  opts = opts or {}
  local name = opts.relative and relative_filename() or vim.api.nvim_buf_get_name(0)
  vim.fn.setreg('*', name)
  vim.notify('Copied: ' .. name)
end

function M.open(opts)
  opts = opts or {}
  local platform = opts.platform or 'github'
  local line = opts.line and vim.api.nvim_win_get_cursor(0)[1] or nil
  local branch = platform == 'github' and (opts.branch or git('branch --show-current')) or nil
  local remote = git('remote get-url origin')
  local repo = parse_repo(remote)

  if not repo then
    vim.notify('Could not parse remote URL: ' .. remote, vim.log.levels.WARN)
    return
  end

  local file = relative_filename()
  local url

  if platform == 'github' then
    url = 'https://github.com/' .. repo .. '/blob/' .. branch .. '/' .. file
    if line then url = url .. '#L' .. line end
  elseif platform == 'sourcegraph' then
    url = M.config.sourcegraph_url .. M.config.sourcegraph_prefix .. '/github.com/' .. repo .. '/-/blob/' .. file
    if line then url = url .. '?L' .. line end
  end

  vim.ui.open(url)
end

return M

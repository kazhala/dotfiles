local au = require('kaz.utils.au')
local kb = require('kaz.utils.kb')

au.augroup('BufInitSettings', {
  {
    event = 'BufReadPost',
    pattern = '*',
    command = [[call setpos(".", getpos("'\""))]],
  },
  {
    event = 'BufEnter',
    pattern = '*',
    callback = function()
      vim.opt.formatoptions:remove('c')
      vim.opt.formatoptions:remove('r')
      vim.opt.formatoptions:remove('o')
    end,
  },
})

au.augroup('FileTypeSettings', {
  {
    event = 'BufEnter',
    pattern = '*',
    callback = function()
      if vim.api.nvim_buf_get_option(0, 'filetype') == '' then
        vim.api.nvim_buf_set_keymap(0, 'n', 'q', '<CMD>:q<CR>', kb.silent_noremap)
      end
    end,
  },
  {
    event = 'BufEnter',
    pattern = 'vifmrc,*.vifm',
    callback = function()
      vim.opt_local.filetype = 'vim'
    end,
  },
  {
    event = 'BufEnter',
    pattern = '*.hcl',
    callback = function()
      vim.opt_local.filetype = 'hcl'
    end,
  },
  {
    event = 'BufEnter',
    pattern = '*.tf,*.tfvars',
    callback = function()
      vim.opt_local.filetype = 'terraform'
    end,
  },
  {
    event = 'BufEnter',
    pattern = '.env',
    callback = function()
      vim.opt_local.filetype = 'sh'
    end,
  },
  {
    event = 'BufEnter',
    pattern = '*.md',
    command = [[setlocal spell]],
  },
})

au.augroup('YankHighlight', {
  {
    event = 'TextYankPost',
    pattern = '*',
    callback = function()
      vim.highlight.on_yank()
    end,
  },
})

au.augroup('CheckOutsideTime', {
  {
    event = 'WinEnter,BufWinEnter,BufWinLeave,BufRead,BufEnter,FocusGained',
    pattern = '*',
    command = 'silent! checktime',
  },
})

local function clear_commandline()
  local timer
  return function()
    if timer then
      timer:stop()
    end
    timer = vim.defer_fn(function()
      if vim.fn.mode() == 'n' then
        vim.cmd([[echon '']])
      end
    end, 10000)
  end
end

au.augroup('ClearCommandMessages', {
  {
    event = 'CmdlineLeave,CmdlineChanged',
    pattern = ':',
    callback = clear_commandline(),
  },
})

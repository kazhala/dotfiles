local au = require('kaz.utils.au')

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
    pattern = '*.tf',
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

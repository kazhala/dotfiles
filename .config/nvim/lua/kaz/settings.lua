vim.opt.mouse = 'a'
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.hidden = true
vim.opt.wrap = false
vim.opt.scrolloff = 5
vim.opt.matchpairs:append('<:>')
vim.opt.history = 10000
vim.opt.showtabline = 2
vim.opt.showmode = false
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = 'split'
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.writebackup = false
vim.opt.updatetime = 300
vim.opt.signcolumn = 'yes'
vim.opt.shortmess:append('c')
vim.opt.shortmess:append('s')
vim.opt.swapfile = false
vim.opt.completeopt = 'menuone,noselect'
vim.opt.pumheight = 20
vim.opt.laststatus = 3

vim.g.floating_window_border = {
  '╭',
  '─',
  '╮',
  '│',
  '╯',
  '─',
  '╰',
  '│',
}

vim.g.diagnostic_icons = {
  Error = '',
  Warning = '',
  Information = '',
  Hint = 'ﴞ',
  Other = '',
}

local disabled_built_ins = {
  'netrw',
  'netrwPlugin',
  'netrwSettings',
  'netrwFileHandlers',
  'gzip',
  'zip',
  'zipPlugin',
  'tar',
  'tarPlugin',
  'getscript',
  'getscriptPlugin',
  'vimball',
  'vimballPlugin',
  '2html_plugin',
  'logipat',
  'rrhelper',
  'spellfile_plugin',
  'matchit',
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g['loaded_' .. plugin] = 1
end

if os.getenv('OS_DISTRO') == 'WSL_UBUNTU' then
  vim.g.clipboard = {
    name = 'win32yank-wsl',
    copy = {
      ['+'] = 'win32yank.exe -i --crlf',
      ['*'] = 'win32yank.exe -i --crlf',
    },
    paste = {
      ['+'] = 'win32yank.exe -o --lf',
      ['*'] = 'win32yank.exe -o --lf',
    },
    cache_enable = 0,
  }
end

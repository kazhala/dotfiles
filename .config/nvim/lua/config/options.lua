-- display
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.scrolloff = 5
vim.opt.showmode = false
vim.opt.showtabline = 2
vim.opt.laststatus = 3
vim.opt.signcolumn = 'yes'

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = 'split'

-- splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

-- behaviour
vim.opt.mouse = 'a'
vim.opt.guicursor:append('a:blinkon0')
vim.opt.matchpairs:append('<:>')
vim.opt.updatetime = 300
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.shortmess:append('s')

-- globals (used by LSP config)
vim.g.floating_window_border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' }
vim.g.diagnostic_icons = {
  Error = '',
  Warning = '',
  Information = '',
  Hint = '',
}

-- disable unused built-in plugins for faster startup
local disabled_built_ins = {
  'netrw', 'netrwPlugin', 'netrwSettings', 'netrwFileHandlers',
  'gzip', 'zip', 'zipPlugin', 'tar', 'tarPlugin',
  'getscript', 'getscriptPlugin', 'vimball', 'vimballPlugin',
  '2html_plugin', 'logipat', 'rrhelper', 'spellfile_plugin', 'matchit',
}
for _, plugin in pairs(disabled_built_ins) do
  vim.g['loaded_' .. plugin] = 1
end

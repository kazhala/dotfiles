local g = {
  buf_init = vim.api.nvim_create_augroup('BufInitSettings', { clear = true }),
  filetype = vim.api.nvim_create_augroup('FileTypeSettings', { clear = true }),
  yank = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
  check_time = vim.api.nvim_create_augroup('CheckOutsideTime', { clear = true }),
  clear_cmd = vim.api.nvim_create_augroup('ClearCommandMessages', { clear = true }),
  oil_aug = vim.api.nvim_create_augroup('OilBarbarFix', { clear = true }),
  lsp = vim.api.nvim_create_augroup('LspDiagnosticFloat', { clear = true }),
}

vim.filetype.add({
  filename = {
    ['vifmrc'] = 'vim',
    ['.env'] = 'sh',
  },
  extension = {
    vifm = 'vim',
    hcl = 'hcl',
    tf = 'terraform',
    tfvars = 'terraform',
  },
})

-- oil buffers must be unlisted before barbar's BufNew/BufEnter handlers fire.
-- :edit (called internally by oil) temporarily sets buflisted=true, causing barbar
-- to flash the buffer in the tabline before oil corrects it. registering here
-- (before any plugin loads) ensures our handler runs first.
vim.api.nvim_create_autocmd({ 'BufNew', 'BufEnter' }, {
  group = g.oil_aug,
  callback = function(args)
    if vim.api.nvim_buf_get_name(args.buf):match('^oil://') then
      vim.bo[args.buf].buflisted = false
    end
  end,
})

-- oil does not save cursor position on BufLeave, so returning from fzf or any
-- other window loses the position. save it into oil's own internal cache so
-- its BufEnter handler can restore it normally.
vim.api.nvim_create_autocmd('BufLeave', {
  group = g.oil_aug,
  callback = function(args)
    local bufname = vim.api.nvim_buf_get_name(args.buf)
    if not bufname:match('^oil://') then
      return
    end
    local ok_oil, oil = pcall(require, 'oil')
    local ok_view, view = pcall(require, 'oil.view')
    if not ok_oil or not ok_view then
      return
    end
    local entry = oil.get_cursor_entry()
    if entry then
      view.set_last_cursor(bufname, entry.name)
    end
  end,
})

-- show diagnostic float on cursor hold
vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
  group = g.lsp,
  callback = function()
    vim.diagnostic.open_float()
  end,
})

-- restore cursor position on file open (skip special buffers like oil)
vim.api.nvim_create_autocmd('BufReadPost', {
  group = g.buf_init,
  callback = function()
    if vim.bo.buftype ~= '' then
      return
    end
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- disable auto comment continuation on new lines
vim.api.nvim_create_autocmd('BufEnter', {
  group = g.buf_init,
  callback = function()
    vim.opt.formatoptions:remove({ 'c', 'r', 'o' })
  end,
})

-- map q to close on buffers with no filetype or specific read-only filetypes
vim.api.nvim_create_autocmd('BufEnter', {
  group = g.filetype,
  callback = function()
    if vim.bo.filetype == '' then
      vim.keymap.set('n', 'q', '<CMD>q<CR>', { silent = true, buffer = true })
    end
  end,
})
vim.api.nvim_create_autocmd('FileType', {
  group = g.filetype,
  pattern = { 'help', 'man', 'qf' },
  callback = function()
    vim.keymap.set('n', 'q', '<CMD>q<CR>', { silent = true, buffer = true })
  end,
})

-- filetype-specific settings
vim.api.nvim_create_autocmd('FileType', {
  group = g.filetype,
  pattern = 'markdown',
  callback = function()
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = g.filetype,
  pattern = 'go',
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

-- flash highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = g.yank,
  callback = function()
    vim.hl.on_yank()
  end,
})

-- auto-reload files changed outside nvim
vim.api.nvim_create_autocmd({ 'WinEnter', 'BufWinEnter', 'BufWinLeave', 'BufRead', 'BufEnter', 'FocusGained' }, {
  group = g.check_time,
  command = 'silent! checktime',
})

-- clear command line after 10 seconds
local clear_timer
local function start_clear_timer()
  if clear_timer then
    clear_timer:stop()
  end
  clear_timer = vim.defer_fn(function()
    if vim.fn.mode() == 'n' then
      vim.api.nvim_echo({}, false, {})
    end
  end, 10000)
end

vim.api.nvim_create_autocmd({ 'CmdlineLeave', 'CmdlineChanged' }, {
  group = g.clear_cmd,
  pattern = ':',
  callback = start_clear_timer,
})
vim.api.nvim_create_autocmd('TextYankPost', {
  group = g.clear_cmd,
  callback = start_clear_timer,
})

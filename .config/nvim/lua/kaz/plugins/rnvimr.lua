vim.keymap.set({ 'n', 't' }, '<C-b>', '<CMD>RnvimrToggle<CR>')

vim.g.rnvimr_layout = {
  relative = 'editor',
  width = math.floor((1 * vim.o.columns) + 0.5),
  height = math.floor((0.4 * vim.o.lines) + 0.5),
  col = 0,
  row = math.floor((0.6 * vim.o.lines) + 0.5),
  style = 'minimal',
}

vim.g.rnvimr_draw_border = false
vim.g.rnvimr_enable_bw = true

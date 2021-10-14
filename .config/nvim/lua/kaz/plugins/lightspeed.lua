require('lightspeed').setup({
  instant_repeat_fwd_key = ';',
  instant_repeat_bwd_key = ',',
})

vim.api.nvim_set_keymap('n', 'r', '<Plug>Lightspeed_s', {})
vim.api.nvim_set_keymap('n', 'R', '<Plug>Lightspeed_S', {})

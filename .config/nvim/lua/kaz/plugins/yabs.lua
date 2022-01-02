local kb = require('kaz.utils.kb')

require('yabs'):setup({
  languages = {
    python = {
      tasks = {
        run = {
          command = 'python3 %',
          output = 'buffer',
        },
        test = {
          command = 'python3 -m unittest %',
          output = 'buffer',
        },
      },
    },
  },
})

vim.api.nvim_set_keymap('n', '<leader>yr', [[<CMD>lua require('yabs'):run_task('run')<CR>]], kb.silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>yt', [[<CMD>lua require('yabs'):run_task('test')<CR>]], kb.silent_noremap)

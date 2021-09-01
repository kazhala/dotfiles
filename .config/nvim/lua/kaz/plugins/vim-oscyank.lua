vim.g.oscyank_max_length = 100000

require('kaz.utils.au').augroup('OSCYANK', {
  {
    event = 'TextYankPost',
    pattern = '*',
    command = [[if v:event.operator is 'y' && v:event.regname is '*' | OSCYankReg * | endif]],
  },
})

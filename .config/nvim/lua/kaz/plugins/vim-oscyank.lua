require('kaz.utils.au').augroup('OSCYANK', {
  {
    event = 'TextYankPost',
    pattern = '*',
    command = [[if v:event.operator is 'y' && v:event.regname is '*' | call YankOSC52(getreg('*')) | endif]],
  },
})

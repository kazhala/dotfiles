augroup PythonSettings
  autocmd! * <buffer>
  autocmd BufWritePre <buffer> execute ':Black'
  autocmd BufWinEnter <buffer> setlocal autoindent
  autocmd BufWinEnter <buffer> setlocal tabstop=4
  autocmd BufWinEnter <buffer> setlocal shiftwidth=4
  autocmd BufWinEnter <buffer> setlocal softtabstop=4
  autocmd BufWinEnter <buffer> setlocal expandtab
augroup end

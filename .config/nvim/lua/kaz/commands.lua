vim.cmd([[
command! -nargs=1 Unload lua require('kaz.utils.unload').run(<q-args>)
command! -nargs=1 UnloadAuto lua require('kaz.utils.unload').on_save(<q-args>)
]])

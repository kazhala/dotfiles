local colors = require('nordic.palette')

require('nordic').colorscheme({ italic = false, italic_comments = true })

vim.cmd([[
hi EndOfBuffer guifg=bg

highlight! link LspReferenceRead CursorLine
highlight! link LspReferenceWrite CursorLine
highlight! link LspReferenceText CursorLine

highlight TelescopeSelection guibg=NONE
highlight! link TelescopeMatching String
highlight! link TelescopeMultiSelection SpecialComment

highlight NormalFloat guibg=NONE
highlight CmpItemMenu guibg=NONE
]])

vim.cmd([[highlight FloatBorder gui=bold guibg=NONE guifg=]] .. colors.gray)
vim.cmd([[highlight GitSignsChange guifg=]] .. colors.intense_blue)
vim.cmd([[highlight StatusLine guibg=]] .. colors.dark_black)
vim.cmd([[highlight StatusLineNC guibg=]] .. colors.dark_black)
vim.cmd([[highlight IndentBlanklineContextChar gui=nocombine guifg=]] .. colors.blue)

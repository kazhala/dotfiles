local shfmt = function()
  return { exe = 'shfmt', stdin = true }
end
local black = function()
  return { exe = 'black', args = { '-' }, stdin = true }
end
local isort = function()
  return { exe = 'isort', args = { '-' }, stdin = true }
end

require('formatter').setup({
  logging = false,
  filetype = {
    lua = {
      function()
        return { exe = 'lua-format', stdin = true }
      end,
    },
    python = { black, isort },
    sh = { shfmt },
    zsh = { shfmt },
    tf = {
      function()
        return { exe = 'terraform', args = { 'fmt' }, stdin = false }
      end,
    },
  },
})

require('kaz.utils.au').augroup('AutoFormat', {
  { event = 'BufWritePost', pattern = '*.lua,', command = [[silent FormatWrite]] },
  { event = 'BufWritePost', pattern = '*.py', command = [[silent FormatWrite]] },
  {
    event = 'FileType',
    pattern = 'sh',
    command = [[autocmd BufWritePost * silent FormatWrite]],
  },
})

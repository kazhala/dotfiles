return {
  'coder/claudecode.nvim',
  event = 'VeryLazy',
  opts = {
    auto_start = true,
    terminal_cmd = vim.fn.executable('otter') == 1 and 'otter claude-code' or 'claude',
    terminal = {
      provider = 'none',
    },
  },
  keys = {
    { '<leader>as', '<cmd>ClaudeCodeAdd %<cr>', desc = 'Add current buffer' },
    { '<leader>as', '<cmd>ClaudeCodeSend<cr>', mode = 'v', desc = 'Send to Claude' },
    {
      '<leader>as',
      '<cmd>ClaudeCodeTreeAdd<cr>',
      desc = 'Add file',
      ft = { 'oil' },
    },
    { '<leader>aa', '<cmd>ClaudeCodeDiffAccept<cr>', desc = 'Accept Claude diff' },
    { '<leader>ad', '<cmd>ClaudeCodeDiffDeny<cr>', desc = 'Deny Claude diff' },
  },
}

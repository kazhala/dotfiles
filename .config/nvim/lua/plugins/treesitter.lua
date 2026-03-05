return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').install({
        'lua',
        'vim',
        'vimdoc',
        'c',
        'python',
        'go',
        'gomod',
        'yaml',
        'json',
        'toml',
        'hcl',
        'terraform',
        'jsonnet',
        'bash',
        'comment',
      })

      -- Enable treesitter highlighting for any filetype that has a parser
      vim.api.nvim_create_autocmd('FileType', {
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })

      -- Apply to the initial buffer since its FileType already fired before this autocmd was registered
      pcall(vim.treesitter.start)
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    lazy = false,
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('nvim-treesitter-textobjects').setup({
        select = { lookahead = true },
        move = { set_jumps = true },
      })

      local map = vim.keymap.set
      local sel = require('nvim-treesitter-textobjects.select')
      local mov = require('nvim-treesitter-textobjects.move')
      local swp = require('nvim-treesitter-textobjects.swap')

      -- Select
      map({ 'x', 'o' }, 'af', function()
        sel.select_textobject('@function.outer', 'textobjects')
      end)
      map({ 'x', 'o' }, 'if', function()
        sel.select_textobject('@function.inner', 'textobjects')
      end)
      map({ 'x', 'o' }, 'ac', function()
        sel.select_textobject('@class.outer', 'textobjects')
      end)
      map({ 'x', 'o' }, 'ic', function()
        sel.select_textobject('@class.inner', 'textobjects')
      end)

      -- Move
      map({ 'n', 'x', 'o' }, ']m', function()
        mov.goto_next_start('@function.outer', 'textobjects')
      end)
      map({ 'n', 'x', 'o' }, ']]', function()
        mov.goto_next_start('@class.outer', 'textobjects')
      end)
      map({ 'n', 'x', 'o' }, ']M', function()
        mov.goto_next_end('@function.outer', 'textobjects')
      end)
      map({ 'n', 'x', 'o' }, '][', function()
        mov.goto_next_end('@class.outer', 'textobjects')
      end)
      map({ 'n', 'x', 'o' }, '[m', function()
        mov.goto_previous_start('@function.outer', 'textobjects')
      end)
      map({ 'n', 'x', 'o' }, '[[', function()
        mov.goto_previous_start('@class.outer', 'textobjects')
      end)
      map({ 'n', 'x', 'o' }, '[M', function()
        mov.goto_previous_end('@function.outer', 'textobjects')
      end)
      map({ 'n', 'x', 'o' }, '[]', function()
        mov.goto_previous_end('@class.outer', 'textobjects')
      end)

      -- Swap parameters
      map('n', ']a', function()
        swp.swap_next('@parameter.inner')
      end)
      map('n', '[a', function()
        swp.swap_previous('@parameter.inner')
      end)
    end,
  },
}

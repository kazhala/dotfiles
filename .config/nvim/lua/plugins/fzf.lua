return {
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      {
        '<C-p>',
        function()
          require('fzf-lua').files()
        end,
        desc = 'Find files',
      },
      {
        '<C-g>',
        function()
          require('fzf-lua').live_grep()
        end,
        desc = 'Live grep',
      },
      {
        '<C-s>',
        function()
          require('fzf-lua').buffers()
        end,
        desc = 'Buffers',
      },
      {
        '<leader>fp',
        function()
          require('fzf-lua').resume()
        end,
        desc = 'Resume last picker',
      },
      {
        '<leader>fw',
        function()
          require('fzf-lua').grep_cWORD()
        end,
        desc = 'Grep WORD under cursor',
      },
      {
        '<leader>ff',
        function()
          require('fzf-lua').git_status()
        end,
        desc = 'Git status',
      },
      {
        '<leader>fm',
        function()
          require('fzf-lua').marks()
        end,
        desc = 'Marks',
      },
      {
        '<leader>fh',
        function()
          require('fzf-lua').help_tags()
        end,
        desc = 'Help tags',
      },
      {
        '<leader>fq',
        function()
          require('fzf-lua').quickfix()
        end,
        desc = 'Quickfix list',
      },
      {
        '<leader>fb',
        function()
          require('fzf-lua').diagnostics_document()
        end,
        desc = 'Buffer diagnostics',
      },
      {
        '<leader>fn',
        function()
          require('fzf-lua').diagnostics_workspace()
        end,
        desc = 'Workspace diagnostics',
      },
      {
        '<leader>fa',
        function()
          require('fzf-lua').lsp_code_actions()
        end,
        desc = 'Code actions',
      },
      {
        '<leader>fa',
        function()
          require('fzf-lua').lsp_code_actions()
        end,
        desc = 'Code actions',
        mode = 'v',
      },
      {
        'gd',
        function()
          require('fzf-lua').lsp_definitions()
        end,
        desc = 'LSP definitions',
      },
      {
        'gr',
        function()
          require('fzf-lua').lsp_references()
        end,
        desc = 'LSP references',
      },
    },
    config = function()
      local actions = require('fzf-lua.actions')

      require('fzf-lua').setup({
        winopts = {
          border = vim.g.floating_window_border,
          preview = {
            layout = 'flex',
            flip_columns = 150,
            scrollbar = false,
          },
        },
        keymap = {
          fzf = { ['alt-a'] = 'toggle-all' },
        },
        files = {
          cmd = 'fd --type f --hidden --follow --strip-cwd-prefix',
          git_icons = false,
          actions = {
            ['default'] = actions.file_edit_or_qf,
            ['ctrl-q'] = actions.file_sel_to_qf,
          },
        },
        grep = {
          actions = {
            ['default'] = actions.file_edit_or_qf,
            ['ctrl-q'] = actions.file_sel_to_qf,
          },
        },
        buffers = {
          git_icons = false,
          actions = {
            ['ctrl-w'] = actions.buf_del,
            ['ctrl-q'] = actions.file_sel_to_qf,
          },
        },
        quickfix = {
          git_icons = false,
          actions = {
            ['default'] = actions.file_edit_or_qf,
            ['ctrl-q'] = actions.file_sel_to_qf,
          },
        },
        lsp = {
          severity = 'Warning',
          icons = {
            ['Error'] = { icon = vim.g.diagnostic_icons.Error, color = 'red' },
            ['Warning'] = { icon = vim.g.diagnostic_icons.Warning, color = 'yellow' },
            ['Information'] = { icon = vim.g.diagnostic_icons.Information, color = 'blue' },
            ['Hint'] = { icon = vim.g.diagnostic_icons.Hint, color = 'blue' },
          },
          actions = {
            ['default'] = actions.file_edit_or_qf,
            ['ctrl-q'] = actions.file_sel_to_qf,
          },
        },
      })
    end,
  },

  {
    'AckslD/nvim-neoclip.lua',
    event = 'BufReadPost',
    keys = {
      {
        '<leader>fy',
        function()
          require('neoclip.fzf')()
        end,
        desc = 'Clipboard history',
      },
    },
    config = function()
      require('neoclip').setup({
        keys = {
          fzf = {
            select = 'default',
            paste = 'ctrl-j',
            paste_behind = 'ctrl-k',
          },
        },
      })
    end,
  },
}

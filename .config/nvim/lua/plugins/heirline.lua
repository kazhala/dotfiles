return {
  'rebelot/heirline.nvim',
  lazy = false,
  config = function()
    local conditions = require('heirline.conditions')
    local utils = require('heirline.utils')

    local colors = {
      normal = utils.get_highlight('String').fg,
      insert = utils.get_highlight('Statement').fg,
      visual = utils.get_highlight('DiagnosticWarn').fg,
      replace = utils.get_highlight('DiagnosticError').fg,
      inactive = utils.get_highlight('NonText').fg,
    }

    -- vi mode █ block
    local ViMode = {
      init = function(self)
        self.mode = vim.fn.mode(1)
      end,
      static = {
        mode_colors = {
          n = colors.normal,
          i = colors.insert,
          v = colors.visual,
          V = colors.visual,
          ['\22'] = colors.visual,
          R = colors.replace,
          c = colors.inactive,
          s = colors.visual,
          S = colors.visual,
          ['\19'] = colors.visual,
          t = colors.insert,
        },
      },
      provider = '█',
      hl = function(self)
        return { fg = self.mode_colors[self.mode:sub(1, 1)] or colors.normal }
      end,
      update = {
        'ModeChanged',
        pattern = '*:*',
        callback = vim.schedule_wrap(function()
          vim.cmd('redrawstatus')
        end),
      },
    }

    -- file info block: icon + name + flags
    local FileNameBlock = {
      init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
      end,
    }

    local FileIcon = {
      init = function(self)
        local ext = vim.fn.fnamemodify(self.filename, ':e')
        self.icon, self.icon_color = require('nvim-web-devicons').get_icon_color(self.filename, ext, { default = true })
      end,
      provider = function(self)
        return self.icon and (self.icon .. ' ')
      end,
      hl = function(self)
        return { fg = self.icon_color }
      end,
    }

    local FileName = {
      provider = function(self)
        if vim.bo.filetype == 'fzf' then
          return 'fzf-lua'
        end
        if self.filename:match('^oil://') then
          return 'oil'
        end
        local filename = vim.fn.fnamemodify(self.filename, ':.')
        if filename == '' then
          return '[No Name]'
        end
        if not conditions.width_percent_below(#filename, 0.25) then
          filename = vim.fn.pathshorten(filename)
        end
        return filename
      end,
      hl = { fg = utils.get_highlight('Directory').fg },
    }

    local FileFlags = {
      {
        condition = function()
          return vim.bo.modified
        end,
        provider = ' [+]',
      },
      {
        condition = function()
          return not vim.bo.modifiable or vim.bo.readonly
        end,
        provider = ' ',
        hl = { fg = utils.get_highlight('DiagnosticWarn').fg },
      },
    }

    FileNameBlock = utils.insert(FileNameBlock, FileIcon, FileName, FileFlags, { provider = '%<' })

    local LSPActive = {
      condition = conditions.lsp_attached,
      update = { 'LspAttach', 'LspDetach' },
      provider = function()
        local names = {}
        for _, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
          table.insert(names, server.name)
        end
        return '  ' .. table.concat(names, ' ')
      end,
      hl = { fg = utils.get_highlight('Special').fg },
    }

    local Diagnostics = {
      condition = conditions.has_diagnostics,
      static = {
        icons = vim.g.diagnostic_icons,
      },
      init = function(self)
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
      end,
      update = { 'DiagnosticChanged', 'BufEnter' },
      {
        condition = function(self)
          return self.errors > 0
        end,
        provider = function(self)
          return ' ' .. self.icons.Error .. ' ' .. self.errors
        end,
        hl = { fg = utils.get_highlight('DiagnosticError').fg },
      },
      {
        condition = function(self)
          return self.warnings > 0
        end,
        provider = function(self)
          return ' ' .. self.icons.Warning .. ' ' .. self.warnings
        end,
        hl = { fg = utils.get_highlight('DiagnosticWarn').fg },
      },
      {
        condition = function(self)
          return self.hints > 0
        end,
        provider = function(self)
          return ' ' .. self.icons.Hint .. ' ' .. self.hints
        end,
        hl = { fg = utils.get_highlight('DiagnosticHint').fg },
      },
      {
        condition = function(self)
          return self.info > 0
        end,
        provider = function(self)
          return ' ' .. self.icons.Information .. ' ' .. self.info
        end,
        hl = { fg = utils.get_highlight('DiagnosticInfo').fg },
      },
    }

    local Git = {
      condition = conditions.is_git_repo,

      init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict or {}
        self.has_changes = (self.status_dict.added or 0) ~= 0
          or (self.status_dict.removed or 0) ~= 0
          or (self.status_dict.changed or 0) ~= 0
      end,

      hl = { fg = utils.get_highlight('Statement').fg },

      { -- git branch name
        provider = function(self)
          return ' ' .. (self.status_dict.head or '')
        end,
        hl = { bold = true },
      },
      -- You could handle delimiters, icons and counts similar to Diagnostics
      {
        condition = function(self)
          return self.has_changes
        end,
        provider = '(',
      },
      {
        provider = function(self)
          local count = self.status_dict.added or 0
          return count > 0 and ('+' .. count)
        end,
        hl = { fg = utils.get_highlight('GitSignsAdd').fg },
      },
      {
        provider = function(self)
          local count = self.status_dict.removed or 0
          return count > 0 and ('-' .. count)
        end,
        hl = { fg = utils.get_highlight('GitSignsDelete').fg },
      },
      {
        provider = function(self)
          local count = self.status_dict.changed or 0
          return count > 0 and ('~' .. count)
        end,
        hl = { fg = utils.get_highlight('GitSignsChange').fg },
      },
      {
        condition = function(self)
          return self.has_changes
        end,
        provider = ')',
      },
    }

    local Ruler = {
      provider = ' 󱁐 %l/%L ',
      hl = { fg = colors.inactive },
    }

    local StatusLine = {
      -- left
      ViMode,
      { provider = ' ' },
      FileNameBlock,
      LSPActive,
      Diagnostics,

      -- split
      { provider = '%=' },

      -- right
      Git,
      Ruler,
      ViMode,
    }

    require('heirline').setup({ statusline = StatusLine })
  end,
}

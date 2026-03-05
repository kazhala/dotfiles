return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  config = function()
    require('catppuccin').setup({
      flavour = 'frappe',
      no_italic = true,
      integrations = {
        barbar = true,
      },
      custom_highlights = function(colors)
        return {
          -- hide end of buffer ~ characters
          EndOfBuffer = { fg = colors.base },

          -- transparent floating windows
          NormalFloat = { bg = 'NONE' },
          FloatBorder = { fg = colors.surface2, bg = 'NONE', bold = true },

          -- fix barbar diagnostic icon backgrounds inheriting terminal black instead of tab bg
          BufferCurrentERROR = { fg = colors.red, bg = colors.surface1 },
          BufferCurrentWARN = { fg = colors.yellow, bg = colors.surface1 },
          BufferInactiveERROR = { fg = colors.red, bg = colors.mantle },
          BufferInactiveWARN = { fg = colors.yellow, bg = colors.mantle },
          BufferVisibleERROR = { fg = colors.red, bg = colors.mantle },
          BufferVisibleWARN = { fg = colors.yellow, bg = colors.mantle },
          BufferAlternateERROR = { fg = colors.red, bg = colors.mantle },
          BufferAlternateWARN = { fg = colors.yellow, bg = colors.mantle },
        }
      end,
    })
    vim.cmd.colorscheme('catppuccin')
  end,
}

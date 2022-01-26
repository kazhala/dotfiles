local colors = require('nordic.palette')
local lsp = require('feline.providers.lsp')
local vi_mode_utils = require('feline.providers.vi_mode')

local vi_mode_colors = {
  NORMAL = colors.green,
  INSERT = colors.blue,
  VISUAL = colors.purple,
  OP = colors.green,
  BLOCK = colors.purple,
  REPLACE = colors.red,
  ['V-REPLACE'] = colors.red,
  ENTER = colors.yellow,
  MORE = colors.yellow,
  SELECT = colors.orange,
  COMMAND = colors.yellow,
  SHELL = colors.yellow,
  TERM = colors.intense_blue,
  NONE = colors.white,
}

local function vimode_hl()
  return {
    name = vi_mode_utils.get_mode_highlight_name(),
    fg = vi_mode_utils.get_mode_color(),
  }
end

local function startscreen_enable()
  if
    vim.fn.argc() == 0
    and vim.fn.line2byte('$') == -1
    and vim.fn.len(vim.fn.getbufinfo({ buflisted = true })) == 1
  then
    return false
  end
  return true
end

local function paste_provider()
  return vim.o.paste and ' ' or ''
end

local function position_provider()
  return vim.fn.line('.') .. '/' .. vim.fn.line('$')
end

local function toggleterm_enable()
  return vim.bo.filetype == 'toggleterm'
end

local function toggleterm_provider()
  return ' Terminal ' .. '(' .. vim.b.toggle_number .. ')'
end

local function vi_mode_enable()
  return not toggleterm_enable()
end

local function file_info_enable()
  return not toggleterm_enable()
end

local function lsp_enable()
  return not toggleterm_enable() and startscreen_enable() and lsp.is_lsp_attached()
end

local comps = {
  vi_mode = {
    left = { provider = '█', hl = vimode_hl, right_sep = ' ', enabled = vi_mode_enable },
    right = { provider = '█', hl = vimode_hl, left_sep = ' ', enabled = vi_mode_enable },
    paste = { provider = paste_provider, hl = { fg = colors.orange } },
  },
  toggleterm = {
    provider = toggleterm_provider,
    hl = { fg = colors.intense_blue, style = 'bold' },
    enabled = toggleterm_enable,
  },
  file = {
    info = {
      provider = { name = 'file_info', opts = { type = 'relative-short' } },
      hl = { fg = colors.intense_blue, style = 'bold' },
      enabled = file_info_enable,
    },
    type = {
      provider = 'file_type',
      left_sep = ' ',
      hl = { fg = colors.intense_blue, style = 'bold' },
      enabled = startscreen_enable,
    },
  },
  scroll_bar = {
    provider = 'scroll_bar',
    left_sep = ' ',
    hl = vimode_hl,
    enabled = startscreen_enable,
  },
  position = {
    provider = position_provider,
    left_sep = ' ',
    enabled = file_info_enable,
  },
  diagnostic = {
    error = {
      provider = 'diagnostic_errors',
      hl = { fg = colors.red },
    },
    warning = {
      provider = 'diagnostic_warnings',
      hl = { fg = colors.yellow },
    },
    information = {
      provider = 'diagnostic_info',
      hl = { fg = colors.blue },
    },
    hint = {
      provider = 'diagnostic_hints',
      hl = { fg = colors.cyan },
    },
  },
  lsp = {
    name = {
      provider = 'lsp_client_names',
      hl = { fg = colors.bright_cyan },
      enabled = lsp_enable,
      icon = ' ',
      left_sep = ' ',
    },
  },
  git = {
    branch = {
      provider = 'git_branch',
      icon = ' ',
      left_sep = ' ',
      hl = { fg = colors.green, style = 'bold' },
      enabled = startscreen_enable,
    },
    add = { provider = 'git_diff_added', hl = { fg = colors.green } },
    change = { provider = 'git_diff_changed', hl = { fg = colors.intense_blue } },
    remove = { provider = 'git_diff_removed', hl = { fg = colors.red } },
  },
}

local components = {
  active = {
    {
      comps.vi_mode.left,
      comps.file.info,
      comps.toggleterm,
      comps.vi_mode.paste,
      comps.lsp.name,
      comps.diagnostic.error,
      comps.diagnostic.warning,
      comps.diagnostic.hint,
      comps.diagnostic.info,
    },
    {},
    {
      comps.git.add,
      comps.git.change,
      comps.git.remove,
      comps.git.branch,
      comps.position,
      comps.file.type,
      comps.vi_mode.right,
    },
  },
  inactive = {
    {
      {
        provider = ' ',
        hl = { bg = colors.black, style = 'underline', fg = colors.grayish },
      },
    },
  },
}

require('feline').setup({
  theme = {
    fg = colors.white,
    bg = colors.black,
  },
  components = components,
  vi_mode_colors = vi_mode_colors,
  force_inactive = {
    filetypes = { 'packer', 'TelescopePrompt' },
    buftypes = {},
    bufnames = {},
  },
})

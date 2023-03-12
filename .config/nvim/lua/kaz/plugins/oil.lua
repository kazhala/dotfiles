local oil = require('oil')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local make_entry = require('telescope.make_entry')

local M = {}

M.current_dir = nil

local function open()
  if M.current_dir ~= nil then
    oil.open_float(M.current_dir)
  else
    oil.open_float()
  end
end

local function hide()
  M.current_dir = oil.get_current_dir()
  oil.close()
end

local function close()
  M.current_dir = nil
  oil.close()
end

local directory_selection = function(opts)
  opts = opts or {}

  opts.cwd = vim.fn.getcwd()
  opts.entry_maker = opts.entry_maker or make_entry.gen_from_file(opts)

  pickers
    .new(opts, {
      prompt_title = 'Oil Directory',
      finder = finders.new_oneshot_job({ 'fd', '--type', 'd', '--strip-cwd-prefix' }, opts),
      previewer = conf.file_previewer(opts),
      sorter = conf.file_sorter(opts),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          close()
          oil.open_float(selection[1])
        end)
        actions.toggle_selection:replace(function()
          print('Not supported')
        end)
        return true
      end,
    })
    :find()
end

oil.setup({
  columns = {
    'icon',
    'permissions',
  },
  keymaps = {
    ['<C-b>'] = hide,
    ['<C-c>'] = close,
    ['<C-d>'] = directory_selection,
  },
})

vim.keymap.set('n', '<C-b>', function()
  open()
end)

return M

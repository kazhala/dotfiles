local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local make_entry = require('telescope.make_entry')
local trouble = require('trouble')
local kb = require('kaz.utils.kb')

local M = {}

M.dotbare_picker = function(opts)
  opts = opts or {}

  opts.cwd = os.getenv('DOTBARE_TREE')
  opts.entry_maker = opts.entry_maker or make_entry.gen_from_file(opts)

  pickers.new(opts, {
    prompt_title = 'Git Files',
    finder = finders.new_oneshot_job({ 'dotbare', 'ls-files', '--full-name' }, opts),
    previewer = conf.file_previewer(opts),
    sorter = conf.file_sorter(opts),
  }):find()
end

M.file_picker = function(opts)
  if not pcall(require('telescope.builtin').git_files, opts) then
    require('telescope.builtin').find_files(opts)
  end
end

local function smart_enter(prompt_bufnr)
  local picker = action_state.get_current_picker(prompt_bufnr)
  if #picker:get_multi_selection() > 0 then
    actions.send_selected_to_qflist(prompt_bufnr)
    trouble.toggle({ mode = 'quickfix' })
  else
    actions.select_default(prompt_bufnr)
    actions.center()
  end
end

require('telescope').setup({
  defaults = {
    sorting_strategy = 'ascending',
    layout_config = { prompt_position = 'top' },
    prompt_prefix = ' ',
    selection_caret = '» ',
    file_sorter = require('telescope.sorters').get_fzy_sorter,
    mappings = {
      i = {
        ['<M-a>'] = actions.toggle_all,
        ['<C-j>'] = actions.cycle_history_next,
        ['<C-k>'] = actions.cycle_history_prev,
        ['<CR>'] = smart_enter,
        ['<ESC>'] = actions.close,
      },
    },
  },
  pickers = { buffers = { mappings = { i = { ['<c-w>'] = actions.delete_buffer } } } },
})

vim.api.nvim_set_keymap('n', '<C-p>', '<CMD>lua require("kaz.plugins.telescope").file_picker()<CR>', kb.silent_noremap)
vim.api.nvim_set_keymap('n', '<C-m>', '<CMD>Telescope buffers<CR>', kb.silent_noremap)
vim.api.nvim_set_keymap('n', '<C-g>', '<CMD>Telescope live_grep<CR>', kb.silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>fd', '<CMD>Telescope file_browser<CR>', kb.silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>ff', '<CMD>Telescope git_status<CR>', kb.silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>fg', '<CMD>Telescope grep_string<CR>', kb.silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>fm', '<CMD>Telescope marks<CR>', kb.silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>fy', '<CMD>Telescope registers<CR>', kb.silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>fh', '<CMD>Telescope help_tags<CR>', kb.silent_noremap)
vim.api.nvim_set_keymap(
  'n',
  '<leader>fa',
  '<CMD>lua require("kaz.plugins.telescope").dotbare_picker()<CR>',
  kb.silent_noremap
)

return M

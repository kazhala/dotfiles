local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local make_entry = require('telescope.make_entry')
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

local function smart_enter(prompt_bufnr)
  local picker = action_state.get_current_picker(prompt_bufnr)
  if #picker:get_multi_selection() > 0 then
    actions.send_selected_to_qflist(prompt_bufnr)
    vim.cmd('copen')
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
  pickers = {
    buffers = { mappings = { i = { ['<c-w>'] = actions.delete_buffer } } },
    find_files = {
      find_command = { 'fd', '--type', 'f', '--strip-cwd-prefix' },
    },
  },
})

require('neoclip').setup({
  keys = {
    telescope = {
      i = {
        select = '<CR>',
        paste = '<C-j>',
        paste_behind = '<C-k>',
      },
      n = {
        select = '<CR>',
        paste = 'p',
        paste_behind = 'P',
      },
    },
  },
})

vim.keymap.set('n', '<C-p>', [[<CMD>Telescope find_files<CR>]])
vim.keymap.set('n', '<C-s>', [[<CMD>Telescope buffers<CR>]])
vim.keymap.set('n', '<C-g>', [[<CMD>Telescope live_grep<CR>]])
vim.keymap.set('n', '<leader>fs', [[<CMD>Telescope lsp_code_actions<CR>]])
vim.keymap.set('v', '<leader>fs', [[<CMD>Telescope lsp_range_code_actions<CR>]])
vim.keymap.set('n', '<leader>ff', [[<CMD>Telescope git_status<CR>]])
vim.keymap.set('n', '<leader>fw', [[<CMD>Telescope grep_string<CR>]])
vim.keymap.set('n', '<leader>fg', [[<CMD>Telescope git_files<CR>]])
vim.keymap.set('n', '<leader>fm', [[<CMD>Telescope marks<CR>]])
vim.keymap.set('n', '<leader>fy', [[<CMD>Telescope neoclip y<CR>]])
vim.keymap.set('n', '<leader>fh', [[<CMD>Telescope help_tags<CR>]])
vim.keymap.set('n', '<leader>fb', [[<CMD>Telescope diagnostics bufnr=0<CR>]])
vim.keymap.set('n', '<leader>fn', [[<CMD>Telescope diagnostics<CR>]])

vim.keymap.set('n', 'gr', [[<CMD>Telescope lsp_references<CR>]])
vim.keymap.set('n', 'gd', [[<CMD>Telescope lsp_definitions<CR>]])

vim.keymap.set('n', '<leader>fa', [[<CMD>lua require("kaz.plugins.telescope").dotbare_picker()<CR>]])

return M

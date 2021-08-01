-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/kevinzhuang/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/kevinzhuang/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/kevinzhuang/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/kevinzhuang/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/kevinzhuang/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  LuaSnip = {
    config = { "require('kaz.plugins.luasnip')" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/kevinzhuang/.local/share/nvim/site/pack/packer/opt/LuaSnip"
  },
  ["Navigator.nvim"] = {
    config = { "require('kaz.plugins.navigator')" },
    keys = { { "n", "<C-l>" }, { "n", "<C-h>" }, { "n", "<C-j>" }, { "n", "<C-k>" } },
    loaded = false,
    needs_bufread = false,
    path = "/Users/kevinzhuang/.local/share/nvim/site/pack/packer/opt/Navigator.nvim"
  },
  ["close-buffers.nvim"] = {
    commands = { "BDelete", "BWipeout" },
    config = { "require('kaz.plugins.close-buffers')" },
    keys = { { "n", "<leader>t" } },
    loaded = false,
    needs_bufread = false,
    path = "/Users/kevinzhuang/.local/share/nvim/site/pack/packer/opt/close-buffers.nvim"
  },
  ["feline.nvim"] = {
    config = { "require('kaz.plugins.feline')" },
    load_after = {},
    loaded = false,
    needs_bufread = false,
    path = "/Users/kevinzhuang/.local/share/nvim/site/pack/packer/opt/feline.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { "require('kaz.plugins.gitsigns')" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/kevinzhuang/.local/share/nvim/site/pack/packer/opt/gitsigns.nvim"
  },
  ["hop.nvim"] = {
    commands = { "HopWord" },
    config = { "require('kaz.plugins.hop')" },
    keys = { { "n", "r" }, { "n", "R" } },
    loaded = false,
    needs_bufread = false,
    path = "/Users/kevinzhuang/.local/share/nvim/site/pack/packer/opt/hop.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "require('kaz.plugins.indent-blankline')" },
    load_after = {},
    loaded = false,
    needs_bufread = false,
    path = "/Users/kevinzhuang/.local/share/nvim/site/pack/packer/opt/indent-blankline.nvim"
  },
  kommentary = {
    config = { "require('kaz.plugins.kommentary')" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/kevinzhuang/.local/share/nvim/site/pack/packer/opt/kommentary"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "/Users/kevinzhuang/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim"
  },
  nordbuddy = {
    after = { "nvim-bufferline.lua", "feline.nvim" },
    loaded = true,
    only_config = true
  },
  ["nvim-autopairs"] = {
    config = { "require('kaz.plugins.nvim-autopairs')" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/kevinzhuang/.local/share/nvim/site/pack/packer/opt/nvim-autopairs"
  },
  ["nvim-bufferline.lua"] = {
    config = { "require('kaz.plugins.nvim-bufferline')" },
    load_after = {},
    loaded = false,
    needs_bufread = false,
    path = "/Users/kevinzhuang/.local/share/nvim/site/pack/packer/opt/nvim-bufferline.lua"
  },
  ["nvim-compe"] = {
    after_files = { "/Users/kevinzhuang/.local/share/nvim/site/pack/packer/opt/nvim-compe/after/plugin/compe.vim" },
    config = { "require('kaz.plugins.nvim-compe')" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/kevinzhuang/.local/share/nvim/site/pack/packer/opt/nvim-compe"
  },
  ["nvim-lspconfig"] = {
    config = { "require('kaz.plugins.lspconfig')" },
    loaded = true,
    path = "/Users/kevinzhuang/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-toggleterm.lua"] = {
    config = { "require('kaz.plugins.nvim-toggleterm')" },
    keys = { { "n", "<C-f>" } },
    loaded = false,
    needs_bufread = false,
    path = "/Users/kevinzhuang/.local/share/nvim/site/pack/packer/opt/nvim-toggleterm.lua"
  },
  ["nvim-treesitter"] = {
    after = { "indent-blankline.nvim" },
    loaded = true,
    only_config = true
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/Users/kevinzhuang/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects"
  },
  ["nvim-web-devicons"] = {
    config = { "require('kaz.plugins.nvim-web-devicons')" },
    loaded = true,
    path = "/Users/kevinzhuang/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/kevinzhuang/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/kevinzhuang/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/kevinzhuang/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  rnvimr = {
    config = { "require('kaz.plugins.rnvimr')" },
    keys = { { "n", "<C-s>" } },
    loaded = false,
    needs_bufread = false,
    path = "/Users/kevinzhuang/.local/share/nvim/site/pack/packer/opt/rnvimr"
  },
  ["telescope.nvim"] = {
    commands = { "Telescope" },
    config = { "require('kaz.plugins.telescope')" },
    keys = { { "n", "<leader>f" }, { "n", "<C-p>" }, { "n", "<C-g>" } },
    loaded = false,
    needs_bufread = false,
    path = "/Users/kevinzhuang/.local/share/nvim/site/pack/packer/opt/telescope.nvim"
  },
  ["trouble.nvim"] = {
    commands = { "TroubleToggle", "Trouble" },
    config = { "require('kaz.plugins.trouble')" },
    keys = { { "n", "<leader>d" }, { "n", "gr" } },
    loaded = false,
    needs_bufread = false,
    path = "/Users/kevinzhuang/.local/share/nvim/site/pack/packer/opt/trouble.nvim"
  },
  ["vim-fugitive"] = {
    commands = { "G" },
    config = { "require('kaz.plugins.fugitive')" },
    keys = { { "n", "<leader>g" } },
    loaded = false,
    needs_bufread = true,
    path = "/Users/kevinzhuang/.local/share/nvim/site/pack/packer/opt/vim-fugitive"
  },
  ["vim-illuminate"] = {
    config = { "require('kaz.plugins.vim-illuminate')" },
    loaded = true,
    path = "/Users/kevinzhuang/.local/share/nvim/site/pack/packer/start/vim-illuminate"
  },
  ["vim-oscyank"] = {
    config = { "require('kaz.plugins.vim-oscyank')" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/kevinzhuang/.local/share/nvim/site/pack/packer/opt/vim-oscyank"
  },
  ["vim-sandwich"] = {
    config = { "require('kaz.plugins.vim-sandwich')" },
    loaded = false,
    needs_bufread = true,
    path = "/Users/kevinzhuang/.local/share/nvim/site/pack/packer/opt/vim-sandwich"
  }
}

time([[Defining packer_plugins]], false)
local module_lazy_loads = {
  ["^trouble"] = "trouble.nvim"
}
local lazy_load_called = {['packer.load'] = true}
local function lazy_load_module(module_name)
  local to_load = {}
  if lazy_load_called[module_name] then return nil end
  lazy_load_called[module_name] = true
  for module_pat, plugin_name in pairs(module_lazy_loads) do
    if not _G.packer_plugins[plugin_name].loaded and string.match(module_name, module_pat) then
      to_load[#to_load + 1] = plugin_name
    end
  end

  if #to_load > 0 then
    require('packer.load')(to_load, {module = module_name}, _G.packer_plugins)
    local loaded_mod = package.loaded[module_name]
    if loaded_mod then
      return function(modname) return loaded_mod end
    end
  end
end

if not vim.g.packer_custom_loader_enabled then
  table.insert(package.loaders, 1, lazy_load_module)
  vim.g.packer_custom_loader_enabled = true
end

-- Config for: nvim-web-devicons
time([[Config for nvim-web-devicons]], true)
require('kaz.plugins.nvim-web-devicons')
time([[Config for nvim-web-devicons]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
require('kaz.plugins.lspconfig')
time([[Config for nvim-lspconfig]], false)
-- Config for: vim-illuminate
time([[Config for vim-illuminate]], true)
require('kaz.plugins.vim-illuminate')
time([[Config for vim-illuminate]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
require('kaz.plugins.nvim-treesitter')
time([[Config for nvim-treesitter]], false)
-- Config for: nordbuddy
time([[Config for nordbuddy]], true)
require('kaz.colors')
time([[Config for nordbuddy]], false)
-- Conditional loads
time("Condition for { 'vim-oscyank' }", true)
if
try_loadstring("\27LJ\2\nJ\0\0\3\0\4\0\n6\0\0\0009\0\1\0'\2\2\0B\0\2\2\6\0\3\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vUBUNTU\14OS_DISTRO\vgetenv\aos\0", "condition", '{ "vim-oscyank" }')
then
time("Condition for { 'vim-oscyank' }", false)
time([[packadd for vim-oscyank]], true)
		vim.cmd [[packadd vim-oscyank]]
	time([[packadd for vim-oscyank]], false)
	-- Config for: vim-oscyank
	time([[Config for vim-oscyank]], true)
	require('kaz.plugins.vim-oscyank')
	time([[Config for vim-oscyank]], false)
else
time("Condition for { 'vim-oscyank' }", false)
end

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file G lua require("packer.load")({'vim-fugitive'}, { cmd = "G", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file BWipeout lua require("packer.load")({'close-buffers.nvim'}, { cmd = "BWipeout", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file BDelete lua require("packer.load")({'close-buffers.nvim'}, { cmd = "BDelete", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Telescope lua require("packer.load")({'telescope.nvim'}, { cmd = "Telescope", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TroubleToggle lua require("packer.load")({'trouble.nvim'}, { cmd = "TroubleToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Trouble lua require("packer.load")({'trouble.nvim'}, { cmd = "Trouble", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file HopWord lua require("packer.load")({'hop.nvim'}, { cmd = "HopWord", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

-- Keymap lazy-loads
time([[Defining lazy-load keymaps]], true)
vim.cmd [[nnoremap <silent> <C-j> <cmd>lua require("packer.load")({'Navigator.nvim'}, { keys = "<lt>C-j>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> R <cmd>lua require("packer.load")({'hop.nvim'}, { keys = "R", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <C-f> <cmd>lua require("packer.load")({'nvim-toggleterm.lua'}, { keys = "<lt>C-f>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <C-k> <cmd>lua require("packer.load")({'Navigator.nvim'}, { keys = "<lt>C-k>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <C-l> <cmd>lua require("packer.load")({'Navigator.nvim'}, { keys = "<lt>C-l>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <C-p> <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "<lt>C-p>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> r <cmd>lua require("packer.load")({'hop.nvim'}, { keys = "r", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> gr <cmd>lua require("packer.load")({'trouble.nvim'}, { keys = "gr", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <C-g> <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "<lt>C-g>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>d <cmd>lua require("packer.load")({'trouble.nvim'}, { keys = "<lt>leader>d", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>t <cmd>lua require("packer.load")({'close-buffers.nvim'}, { keys = "<lt>leader>t", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <C-s> <cmd>lua require("packer.load")({'rnvimr'}, { keys = "<lt>C-s>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>g <cmd>lua require("packer.load")({'vim-fugitive'}, { keys = "<lt>leader>g", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>f <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "<lt>leader>f", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <C-h> <cmd>lua require("packer.load")({'Navigator.nvim'}, { keys = "<lt>C-h>", prefix = "" }, _G.packer_plugins)<cr>]]
time([[Defining lazy-load keymaps]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au BufRead * ++once lua require("packer.load")({'vim-sandwich', 'indent-blankline.nvim', 'gitsigns.nvim', 'kommentary'}, { event = "BufRead *" }, _G.packer_plugins)]]
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'vim-sandwich', 'nvim-autopairs', 'LuaSnip', 'nvim-compe', 'indent-blankline.nvim', 'gitsigns.nvim', 'kommentary'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufWinEnter * ++once lua require("packer.load")({'nvim-bufferline.lua', 'feline.nvim'}, { event = "BufWinEnter *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end

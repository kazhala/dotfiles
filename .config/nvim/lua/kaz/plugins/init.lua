require('lazy').setup({
  'folke/neodev.nvim',
  {
    'andersevenrud/nordic.nvim',
    lazy = false,
    priority = 999,
    config = function()
      require('kaz.colors')
    end,
  },
  {
    'numToStr/Navigator.nvim',
    lazy = false,
    config = function()
      require('kaz.plugins.navigator')
    end,
  },
  -- lazy loaded
  {
    'RRethy/vim-illuminate',
    config = function()
      require('kaz.plugins.vim-illuminate')
    end,
  },
  {
    'neovim/nvim-lspconfig',
    event = 'BufReadPre',
    config = function()
      require('kaz.plugins.lspconfig')
    end,
    dependencies = {
      'ray-x/lsp_signature.nvim',
      'jose-elias-alvarez/null-ls.nvim',
      'RRethy/vim-illuminate',
    },
  },
  {
    'j-hui/fidget.nvim',
    event = 'BufReadPre',
    config = function()
      require('kaz.plugins.fidget')
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = 'BufReadPost',
    config = function()
      require('kaz.plugins.nvim-treesitter')
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    event = 'BufReadPost',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
  },
  'kyazdani42/nvim-web-devicons',
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'AcksLd/nvim-neoclip.lua',
      'kevinhwang91/nvim-bqf',
    },
    config = function()
      require('kaz.plugins.telescope')
    end,
    cmd = 'Telescope',
    keys = { '<leader>f', '<C-p>', 'gd', 'gr', '<C-g>' },
  },
  {
    'kylechui/nvim-surround',
    config = true,
    keys = { 'ys', 'ds', 'cs', { 'S', mode = 'v' } },
    event = 'InsertEnter',
  },
  {
    'ggandor/leap.nvim',
    config = function()
      require('kaz.plugins.leap')
    end,
    keys = { 's', 'S', { 'x', mode = 'v' }, { 'X', mode = 'v' } },
  },
  {
    'Vimjas/vim-python-pep8-indent',
    ft = 'python',
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufReadPost',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('kaz.plugins.indent-blankline')
    end,
  },
  {
    'famiu/feline.nvim',
    event = 'BufWinEnter',
    config = function()
      require('kaz.plugins.feline')
    end,
  },
  {
    'akinsho/bufferline.nvim',
    event = 'BufWinEnter',
    config = function()
      require('kaz.plugins.bufferline')
    end,
  },
  {
    'kazhala/close-buffers.nvim',
    cmd = { 'BDelete', 'BWipeout' },
    keys = { '<leader>t' },
    config = function()
      require('kaz.plugins.close-buffers')
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    keys = { '<leader>h' },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('kaz.plugins.gitsigns')
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'f3fora/cmp-spell',
      'L3MON4D3/LuaSnip',
    },
    config = function()
      require('kaz.plugins.nvim-cmp')
    end,
    event = 'InsertEnter',
  },
  {
    'L3MON4D3/LuaSnip',
    config = function()
      require('kaz.plugins.luasnip')
    end,
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      require('kaz.plugins.nvim-autopairs')
    end,
  },
  {
    'numToStr/Comment.nvim',
    keys = { 'gc', 'gb', { 'gc', mode = 'v' }, { 'gc', mode = 'v' } },
    config = true,
  },
  {
    'akinsho/toggleterm.nvim',
    keys = { '<C-f>' },
    config = function()
      require('kaz.plugins.toggleterm')
    end,
  },
  {
    'stevearc/oil.nvim',
    keys = { '<C-b>' },
    config = function()
      require('kaz.plugins.oil')
    end,
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
  },
  {
    'kwakzalver/duckytype.nvim',
    config = true,
    cmd = 'DuckyType',
  },
}, {
  defaults = {
    lazy = true,
  },
})

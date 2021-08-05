return require('packer').startup({
  function(use)
    use('wbthomason/packer.nvim')
    use({ 'maaslalani/nordbuddy', config = [[require('kaz.colors')]] })
    use({
      'ojroques/vim-oscyank',
      cond = function()
        return os.getenv('OS_DISTRO') == 'UBUNTU'
      end,
      config = [[require('kaz.plugins.vim-oscyank')]],
    })
    use({
      'RRethy/vim-illuminate',
      config = [[require('kaz.plugins.vim-illuminate')]],
    })
    use({
      'neovim/nvim-lspconfig',
      config = [[require('kaz.plugins.lspconfig')]],
      requires = {
        'folke/lua-dev.nvim',
        'ray-x/lsp_signature.nvim',
      },
    })
    use({
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      branch = '0.5-compat',
      config = [[require('kaz.plugins.nvim-treesitter')]],
    })
    use({
      'nvim-treesitter/nvim-treesitter-textobjects',
      branch = '0.5-compat',
      requires = { 'nvim-treesitter/nvim-treesitter' },
    })
    use({
      'kyazdani42/nvim-web-devicons',
      config = [[require('kaz.plugins.nvim-web-devicons')]],
    })
    use({
      'lukas-reineke/indent-blankline.nvim',
      event = { 'BufRead', 'InsertEnter' },
      config = [[require('kaz.plugins.indent-blankline')]],
      after = 'nvim-treesitter',
    })
    use({
      'famiu/feline.nvim',
      event = 'BufWinEnter',
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = [[require('kaz.plugins.feline')]],
      after = 'nordbuddy',
    })
    use({
      'akinsho/nvim-bufferline.lua',
      event = 'BufWinEnter',
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = [[require('kaz.plugins.nvim-bufferline')]],
      after = 'nordbuddy',
    })
    use({
      'kazhala/close-buffers.nvim',
      cmd = { 'BDelete', 'BWipeout' },
      keys = { { 'n', '<leader>t' } },
      config = [[require('kaz.plugins.close-buffers')]],
    })
    use({
      'lewis6991/gitsigns.nvim',
      event = { 'BufRead', 'InsertEnter' },
      requires = { 'nvim-lua/plenary.nvim' },
      config = [[require('kaz.plugins.gitsigns')]],
    })
    use({
      'folke/trouble.nvim',
      cmd = { 'TroubleToggle', 'Trouble' },
      module = { 'trouble' },
      keys = { { 'n', '<leader>d' }, { 'n', 'gr' }, { 'n', 'gd' } },
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = [[require('kaz.plugins.trouble')]],
    })
    use({
      'hrsh7th/nvim-compe',
      event = 'InsertEnter',
      config = [[require('kaz.plugins.nvim-compe')]],
    })
    use({
      'L3MON4D3/LuaSnip',
      event = 'InsertEnter',
      config = [[require('kaz.plugins.luasnip')]],
    })
    use({
      'windwp/nvim-autopairs',
      event = 'InsertEnter',
      config = [[require('kaz.plugins.nvim-autopairs')]],
    })
    use({
      'b3nj5m1n/kommentary',
      event = { 'BufRead', 'InsertEnter' },
      config = [[require('kaz.plugins.kommentary')]],
    })
    use({
      'machakann/vim-sandwich',
      event = { 'BufRead', 'InsertEnter' },
      config = [[require('kaz.plugins.vim-sandwich')]],
    })
    use({
      'phaazon/hop.nvim',
      keys = { { 'n', 'r' }, { 'n', 'R' } },
      cmd = { 'HopWord' },
      config = [[require('kaz.plugins.hop')]],
    })
    use({
      'numToStr/Navigator.nvim',
      keys = { { 'n', '<C-l>' }, { 'n', '<C-h>' }, { 'n', '<C-j>' }, { 'n', '<C-k>' } },
      config = [[require('kaz.plugins.navigator')]],
    })
    use({
      'kevinhwang91/rnvimr',
      keys = { { 'n', '<C-s>' } },
      config = [[require('kaz.plugins.rnvimr')]],
    })
    use({
      'nvim-telescope/telescope.nvim',
      requires = {
        { 'nvim-lua/popup.nvim' },
        { 'nvim-lua/plenary.nvim' },
        { 'folke/trouble.nvim' },
      },
      cmd = { 'Telescope' },
      keys = { { 'n', '<leader>f' }, { 'n', '<C-p>' }, { 'n', '<C-g>' } },
      config = [[require('kaz.plugins.telescope')]],
    })
    use({
      'akinsho/nvim-toggleterm.lua',
      keys = { { 'n', '<C-f>' } },
      config = [[require('kaz.plugins.nvim-toggleterm')]],
    })
    use({
      'tpope/vim-fugitive',
      keys = { { 'n', '<leader>g' } },
      cmd = { 'G' },
      config = [[require('kaz.plugins.fugitive')]],
    })
  end,

  config = {
    display = {
      open_fn = function()
        return require('packer.util').float({
          border = vim.g.floating_window_border,
        })
      end,
    },
  },
})

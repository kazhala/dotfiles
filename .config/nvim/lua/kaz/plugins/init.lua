return require('packer').startup({
  function(use)
    use({ 'wbthomason/packer.nvim' })
    use({
      'andersevenrud/nordic.nvim',
      config = [[require('kaz.colors')]],
    })
    if os.getenv('OS_DISTRO') == 'UBUNTU' then
      use({
        'ojroques/vim-oscyank',
        config = [[require('kaz.plugins.vim-oscyank')]],
      })
    end
    use({
      'RRethy/vim-illuminate',
      config = [[require('kaz.plugins.vim-illuminate')]],
    })
    use({
      'machakann/vim-sandwich',
      config = [[require('kaz.plugins.vim-sandwich')]],
    })
    use({
      'neovim/nvim-lspconfig',
      config = [[require('kaz.plugins.lspconfig')]],
      requires = {
        'folke/lua-dev.nvim',
        'ray-x/lsp_signature.nvim',
        'jose-elias-alvarez/null-ls.nvim',
      },
    })
    use({
      'j-hui/fidget.nvim',
      after = 'nvim-lspconfig',
      config = [[require('kaz.plugins.fidget')]],
    })
    use({
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      config = [[require('kaz.plugins.nvim-treesitter')]],
    })
    use({
      'nvim-treesitter/nvim-treesitter-textobjects',
      after = 'nvim-treesitter',
    })
    use({
      'kyazdani42/nvim-web-devicons',
      config = [[require('kaz.plugins.nvim-web-devicons')]],
    })
    use({
      'Vimjas/vim-python-pep8-indent',
      ft = 'python',
    })
    use({
      'lukas-reineke/indent-blankline.nvim',
      event = { 'BufRead', 'BufNewFile' },
      after = 'nvim-treesitter',
      config = [[require('kaz.plugins.indent-blankline')]],
    })
    use({
      'famiu/feline.nvim',
      event = 'BufWinEnter',
      config = [[require('kaz.plugins.feline')]],
    })
    use({
      'akinsho/bufferline.nvim',
      event = 'BufWinEnter',
      config = [[require('kaz.plugins.bufferline')]],
    })
    use({
      'kazhala/close-buffers.nvim',
      cmd = { 'BDelete', 'BWipeout' },
      keys = { { 'n', '<leader>t' } },
      config = [[require('kaz.plugins.close-buffers')]],
    })
    use({
      'lewis6991/gitsigns.nvim',
      keys = { { 'n', '<leader>h' } },
      requires = { 'nvim-lua/plenary.nvim' },
      config = [[require('kaz.plugins.gitsigns')]],
    })
    use({
      'hrsh7th/nvim-cmp',
      requires = {
        { 'hrsh7th/cmp-path', after = { 'nvim-cmp' } },
        { 'hrsh7th/cmp-buffer', after = { 'nvim-cmp' } },
        { 'hrsh7th/cmp-nvim-lsp', after = { 'nvim-cmp' } },
        { 'f3fora/cmp-spell', after = { 'nvim-cmp' } },
      },
      config = [[require('kaz.plugins.nvim-cmp')]],
      after = { 'LuaSnip' },
    })
    use({
      'L3MON4D3/LuaSnip',
      event = { 'BufRead', 'BufNewFile' },
      config = [[require('kaz.plugins.luasnip')]],
    })
    use({
      'windwp/nvim-autopairs',
      event = { 'BufRead', 'BufNewFile' },
      config = [[require('kaz.plugins.nvim-autopairs')]],
    })
    use({
      'numToStr/Comment.nvim',
      keys = { { 'n', 'gc' }, { 'n', 'gb' }, { 'v', 'gc' }, { 'v', 'gb' } },
      config = [[require('kaz.plugins.Comment')]],
    })
    use({
      'ggandor/lightspeed.nvim',
      keys = { { 'n', 'r' }, { 'n', 'R' }, { 'n', 'f' }, { 'n', 'F' }, { 'n', 't' }, { 'n', 'T' } },
      config = [[require('kaz.plugins.lightspeed')]],
    })
    use({
      'numToStr/Navigator.nvim',
      commit = '6bfcf7d',
      config = [[require('kaz.plugins.navigator')]],
    })
    use({
      'kevinhwang91/rnvimr',
      keys = { { 'n', '<C-b>' } },
      config = [[require('kaz.plugins.rnvimr')]],
    })
    use({
      'akinsho/toggleterm.nvim',
      keys = { { 'n', '<C-f>' } },
      config = [[require('kaz.plugins.toggleterm')]],
    })
    use({
      'kevinhwang91/nvim-bqf',
      after = 'telescope.nvim',
    })
    use({
      'nvim-telescope/telescope.nvim',
      requires = {
        'nvim-lua/plenary.nvim',
        'AcksLd/nvim-neoclip.lua',
      },
      config = [[require('kaz.plugins.telescope')]],
      cmd = { 'Telescope' },
      keys = { { 'n', '<leader>f' }, { 'n', '<C-p>' }, { 'n', '<C-g>' }, { 'n', 'gd' }, { 'n', 'gr' } },
    })
    use({
      'pianocomposer321/yabs.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = [[require('kaz.plugins.yabs')]],
      keys = { { 'n', '<leader>y' } },
    })
    use({
      'nvim-neorg/neorg',
      config = [[require('kaz.plugins.neorg')]],
      requires = 'nvim-lua/plenary.nvim',
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

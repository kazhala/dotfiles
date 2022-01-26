return require('packer').startup({
  function(use)
    use({ 'wbthomason/packer.nvim' })
    use('Vimjas/vim-python-pep8-indent')
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
      event = { 'BufRead', 'BufNewFile' },
      requires = { 'nvim-lua/plenary.nvim' },
      config = [[require('kaz.plugins.gitsigns')]],
    })
    use({
      'hrsh7th/nvim-cmp',
      requires = {
        { 'hrsh7th/cmp-path', after = { 'nvim-cmp' } },
        { 'hrsh7th/cmp-buffer', after = { 'nvim-cmp' } },
        { 'hrsh7th/cmp-nvim-lsp', after = { 'nvim-cmp' } },
        { 'saadparwaiz1/cmp_luasnip', after = { 'nvim-cmp' } },
        { 'f3fora/cmp-spell', after = { 'nvim-cmp' } },
      },
      after = { 'LuaSnip' },
      config = [[require('kaz.plugins.nvim-cmp')]],
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
      'numToStr/Comment.nvim',
      keys = { { 'n', 'gc' }, { 'n', 'gb' }, { 'v', 'gc' }, { 'v', 'gb' } },
      config = [[require('kaz.plugins.Comment')]],
    })
    use({
      'machakann/vim-sandwich',
      keys = { { 'n', 's' }, { 'v', 's' } },
      config = [[require('kaz.plugins.vim-sandwich')]],
    })
    use({
      'ggandor/lightspeed.nvim',
      keys = { { 'n', 'r' }, { 'n', 'R' }, { 'n', 'f' }, { 'n', 'F' }, { 'n', 't' }, { 'n', 'T' } },
      config = [[require('kaz.plugins.lightspeed')]],
    })
    use({
      'numToStr/Navigator.nvim',
      config = [[require('kaz.plugins.navigator')]],
    })
    use({
      'kevinhwang91/rnvimr',
      keys = { { 'n', '<C-s>' } },
      config = [[require('kaz.plugins.rnvimr')]],
    })
    use({
      'akinsho/toggleterm.nvim',
      keys = { { 'n', '<C-f>' } },
      config = [[require('kaz.plugins.toggleterm')]],
    })
    use({
      'TimUntersberger/neogit',
      keys = { { 'n', '<leader>g' } },
      config = [[require('kaz.plugins.neogit')]],
    })
    use({
      'kevinhwang91/nvim-bqf',
      after = 'fzf-lua',
    })
    use({
      'ibhagwan/fzf-lua',
      requires = { 'vijaymarupudi/nvim-fzf' },
      config = [[require('kaz.plugins.fzf-lua')]],
      cmd = { 'FzfLua' },
      keys = { { 'n', '<leader>f' }, { 'n', '<C-p>' }, { 'n', '<C-g>' }, { 'n', 'gd' }, { 'n', 'gr' } },
    })
    use({
      'folke/zen-mode.nvim',
      config = [[require('kaz.plugins.zen-mode')]],
      keys = { { 'n', '<C-t>' } },
      cmd = { 'ZenMode' },
    })
    use({
      'pianocomposer321/yabs.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = [[require('kaz.plugins.yabs')]],
      keys = { { 'n', '<leader>y' } },
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

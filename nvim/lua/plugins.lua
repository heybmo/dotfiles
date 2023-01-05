-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Initialize packer
require('packer').init({
  compile_path = vim.fn.stdpath('data') .. '/site/plugin/packer_compiled.lua',
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'solid' })
    end,
  },
})

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- Speed up startup time
  use 'lewis6991/impatient.nvim'
  -- UI
  use 'ryanoasis/vim-devicons'
  use 'folke/tokyonight.nvim'
  use 'EdenEast/nightfox.nvim'
  use 'savq/melange'
  -- highlight all whitespace
  use 'ntpeters/vim-better-whitespace'
  -- Smooth scrolling
  use 'karb94/neoscroll.nvim'
  -- Syntax Highlighting
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  -- Colorize brackets
  use 'p00f/nvim-ts-rainbow'
  -- Icons
  use 'kyazdani42/nvim-web-devicons'
  -- Autogenerate bracket pairs
  use 'windwp/nvim-autopairs'
  -- Autogenerate tags
  use 'windwp/nvim-ts-autotag'
  -- Customize status line
  use { 'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true } }
  -- Add buffer tab lines
  use { 'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons' }
  use 'rhysd/vim-grammarous' -- grammar check
  use 'andymass/vim-matchup' -- matching parens and more
  use 'tpope/vim-commentary' -- Comment stuff out
  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' }
  }

  -- Autocompletion
  use 'rafamadriz/friendly-snippets'
  use { 'hrsh7th/nvim-cmp', requires = 'onsails/lspkind-nvim' }
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path' -- path completions
  use 'hrsh7th/cmp-cmdline' -- cmdline completions
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip'
  use 'neovim/nvim-lspconfig'
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use {
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
  }

  -- Debugging
  use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }

  -- Browsing/searching
  use 'BurntSushi/ripgrep'
  use 'preservim/nerdtree'
  use { 'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-live-grep-args.nvim' }
    }
  }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'nvim-telescope/telescope-ui-select.nvim'
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'
  use 'tpope/vim-surround'
  use 'folke/which-key.nvim'

  -- Git
  use 'tpope/vim-fugitive'

  -- Languages
  -- Generate docs
  use {
    'kkoomen/vim-doge',
    run = ':call doge#install()'
  }
  -- Golang
  use 'ray-x/go.nvim'
  use 'ray-x/guihua.lua'

  -- Note taking
  use {
    "nvim-neorg/neorg",
    requires = "nvim-lua/plenary.nvim"
  }

  -- Clojure / Lisp development
  use 'Olical/conjure'

  -- Databases / SQL
  use 'nanotee/sqls.nvim'
  use 'tpope/vim-dadbod'
  use {
    'kristijanhusak/vim-dadbod-completion',
    requires = {
      'kristijanhusak/vim-dadbod-ui',
    },
  }
  use 'kristijanhusak/vim-dadbod-ui'
  use 'sbdchd/neoformat'
end)

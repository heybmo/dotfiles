local M = {
  'neovim/nvim-lspconfig',
  lazy = false,
  priority = 999,
  event = 'BufReadPre',
  dependencies = {
      { 'folke/neoconf.nvim', cmd = 'Neoconf', config = true },
      { 'folke/neodev.nvim', config = true },
      'nanotee/sqls.nvim',
      'mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp',
  }
}

function M.config()
  require('plugins.languages.lsp').setup()
  local lspconfig = require('lspconfig')

  lspconfig.gopls.setup(require('plugins.languages.go').lsp)
  lspconfig.pyright.setup(require('plugins.languages.python').lsp)
  lspconfig.sumneko_lua.setup(require('plugins.languages.lua').lsp)
  lspconfig.sqls.setup(require('plugins.languages.sql').lsp)
  lspconfig.html.setup(require('plugins.languages.html').lsp)
  lspconfig.cssls.setup(require('plugins.languages.css').lsp)
  lspconfig.tsserver.setup(require('plugins.languages.typescript').lsp)
  lspconfig.jsonls.setup(require('plugins.languages.json').lsp)
end

return M


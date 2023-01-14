local M = {
  'ray-x/go.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'neovim/nvim-lspconfig',
    'ray-x/guihua.lua',
  },
  event = 'BufEnter *.go',
}

function M.config()
  require('go').setup()

  local format_sync_grp = vim.api.nvim_create_augroup('GoFormat', {})
  vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*.go',
    callback = function()
     require('go.format').goimport()
    end,
    group = format_sync_grp,
  })
end

return M


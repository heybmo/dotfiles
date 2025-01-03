local M = {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  lazy = 'VeryLazy',
  config = function()
    local actions = require('telescope.actions')

    require('telescope').setup({
      defaults = {
        mappings = {
          i = {
            ["<c-d>"] = actions.delete_buffer,
          },
          n = {
            ["<c-d>"] = actions.delete_buffer,
            ["dd"] = actions.delete_buffer,
          },
        },
      },
    })
  end,
}

return M

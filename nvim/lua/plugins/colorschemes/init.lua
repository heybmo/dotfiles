-- This is mostly just to make sure the colorschemes are installed.
-- Loading the colorschemes happens in plugins/init.lua.

local M = {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[ colorscheme tokyonight ]])
    end,
  },
  -- catppuccin
  {
    'catppuccin/nvim',
    name = 'catppuccin',
  },

  colorscheme = 'tokyonight',
  config = function()
    vim.cmd([[ colorscheme tokyonight ]])
  end,
}

--function M.config()
--  vim.cmd([[colorscheme tokyonight]])
--end

return M



local M = {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    opts = {},
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd[[ colorscheme catppuccin ]]
    end
  }
}

return M
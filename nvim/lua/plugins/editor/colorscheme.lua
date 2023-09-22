-- @description All colorschemes

-- List of colorschemes to INSTALL.
-- Activation of colorscheme is below.
local M = {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function (_, opts)
            require("catppuccin/nvim").setup({
                integrations = {
                    cmp = true,
                    tresitter = true,
                }
            })
        end
    },
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        opts = {},
    }
}

return M
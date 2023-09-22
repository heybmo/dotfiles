-- @description Configure bottom tab for statusline using Lualine.

local M = {
    "nvim-lualine/lualine.nvim",
    lazy = true,
    event = "BufEnter",
    dependencies = {
		"nvim-tree/nvim-web-devicons",
        "catppuccin/nvim",
	},
    config = function()
        return {
            sections = {
                lualine_a = {"mode"},
                lualine_b = {"branch", "diff", "diagnostics"},
                lualine_c = {"filename", "searchcount"},
                lualine_x = {"encoding", "fileformat", "filetype"},
                lualine_y = {"progress"},
                lualine_z = {"location"}
              },
        }
    end
}

return M

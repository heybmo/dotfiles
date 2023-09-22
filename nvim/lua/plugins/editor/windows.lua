-- @description Window movement + management.

local M = {
    "anuvyklack/windows.nvim",
    event = "WinNew",
    dependencies = {
        "anuvyklack/middleclass",
        "anuvyklack/animation.nvim"
     },
     keys = {
        {"<leader>zm", "<cmd>WindowsMaximize<cr>", desc = "Toggle Window Maximize"},
        {"<leader>zv", "<cmd>WindowsMaximizeVertically<cr>", desc = "Maximize Windows Vertically"},
        {"<leader>zh", "<cmd>WindowsMaximizeHorizontally<cr>", desc = "Maximize Windows Horizontally"},
        {"<leader>zh", "<cmd>WindowsEqualize<cr>", desc = "Split Windows Equally"},
     },
     config = function()
        vim.o.winwidth = 5
        vim.o.equalalways = false
    end
}

return M
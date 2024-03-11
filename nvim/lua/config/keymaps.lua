-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- WINDOWS
-- Resize windows
vim.keymap.set({ "n", "x", "v" }, "<leader>wh", "<C-w>h", { desc = "Go to left window", remap = true })
vim.keymap.set({ "n", "x", "v" }, "<leader>wj", "<C-w>j", { desc = "Go to top window", remap = true })
vim.keymap.set({ "n", "x", "v" }, "<leader>wl", "<C-w>l", { desc = "Go to right window", remap = true })
vim.keymap.set({ "n", "x", "v" }, "<leader>wk", "<C-w>k", { desc = "Go to bottom window", remap = true })

vim.keymap.set({ "n", "x", "v" }, "<leader>w<left>", "<C-w>h", { desc = "Go to left window", remap = true })
vim.keymap.set({ "n", "x", "v" }, "<leader>w<up>", "<C-w>j", { desc = "Go to top window", remap = true })
vim.keymap.set({ "n", "x", "v" }, "<leader>w<right>", "<C-w>l", { desc = "Go to right window", remap = true })
vim.keymap.set({ "n", "x", "v" }, "<leader>w<down>", "<C-w>k", { desc = "Go to bottom window", remap = true })

-- Toggle frames
vim.keymap.set({ "n" }, "<leader>ft", "<cmd>Neotree toggle current<cr>", { desc = "Open Neotree (cwd)", remap = true })

-- Toggle buffers
vim.keymap.set({ "n" }, "<leader>bj", "<cmd>bprev<cr>", { desc = "Previous buffer", remap = true })
vim.keymap.set({ "n" }, "<leader>bk", "<cmd>bnext<cr>", { desc = "Next buffer", remap = true })

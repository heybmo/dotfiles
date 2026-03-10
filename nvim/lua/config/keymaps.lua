-- Keymaps loaded on the VeryLazy event
-- LazyVim defaults: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
--
-- Tmux alignment:
--   <C-h/j/k/l>  vim-tmux-navigator → seamless split/pane nav (mirrors tmux M-h/j/k/l)
--   <S-h> / <S-l> → prev/next buffer   (mirrors tmux S-Left / S-Right)
--   <leader>|     → vertical split      (mirrors tmux prefix+|)
--   <leader>-     → horizontal split    (mirrors tmux prefix+-)
--
-- Note: <C-h/j/k/l> and <leader>| / <leader>- are already LazyVim defaults
-- and vim-tmux-navigator overrides <C-h/j/k/l> to also navigate tmux panes.

local map = vim.keymap.set

-- Toggle last buffer (like tmux's last-window)
map("n", "<leader><tab>", "<cmd>b#<cr>", { desc = "Toggle last buffer" })

-- Window management (convenience aliases matching muscle memory from tmux)
map("n", "<leader>wv", "<cmd>vsplit<cr>", { desc = "Split vertically" })
map("n", "<leader>wh", "<cmd>split<cr>", { desc = "Split horizontally" })
map("n", "<leader>wq", "<cmd>close<cr>", { desc = "Close window" })

-- Move between windows with arrow keys as a fallback
map("n", "<leader>wH", "<C-w>H", { desc = "Move window left" })
map("n", "<leader>wL", "<C-w>L", { desc = "Move window right" })
map("n", "<leader>wJ", "<C-w>J", { desc = "Move window down" })
map("n", "<leader>wK", "<C-w>K", { desc = "Move window up" })

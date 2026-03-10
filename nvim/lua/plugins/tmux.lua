-- Seamless navigation between neovim splits and tmux panes.
-- Uses the same C-h/j/k/l keys that LazyVim already binds for window nav,
-- extending them to also move across tmux pane boundaries.
--
-- Requires the vim-tmux-navigator plugin in tmux (already in your .tmux.conf).
return {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
  },
  keys = {
    { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>",     desc = "Navigate left (nvim/tmux)" },
    { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>",     desc = "Navigate down (nvim/tmux)" },
    { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>",       desc = "Navigate up (nvim/tmux)" },
    { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>",    desc = "Navigate right (nvim/tmux)" },
    { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>", desc = "Navigate to previous (nvim/tmux)" },
  },
}

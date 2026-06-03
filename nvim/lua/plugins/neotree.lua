return {
  "nvim-neo-tree/neo-tree.nvim",
  -- Override LazyVim's init that auto-opens neo-tree when nvim starts with a directory
  init = function() end,
  dependencies = {
    {
      "s1n7ax/nvim-window-picker",
      name = "window-picker",
      event = "VeryLazy",
      opts = {
        filter_rules = {
          include_current_win = false,
          autoselect_one = true,
          bo = {
            filetype = { "neo-tree", "neo-tree-popup", "notify" },
            buftype = { "terminal", "quickfix" },
          },
        },
      },
    },
  },
}

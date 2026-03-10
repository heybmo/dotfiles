local M = {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    flavour = "macchiato",
    transparent_background = false,
    show_end_of_buffer = false,
    integrations = {
      cmp = true,
      gitsigns = true,
      treesitter = true,
      notify = false,
    },
  },
}

return M


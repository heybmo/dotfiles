return {
  -- Catppuccin: matching ghostty (Frappe dark / Latte light) and tmux (Mocha)
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "frappe",
      transparent_background = false,
      integrations = {
        blink_cmp = true,
        bufferline = true,
        gitsigns = true,
        indent_blankline = { enabled = true },
        mason = true,
        mini = { enabled = true },
        neotree = true,
        noice = true,
        notify = true,
        snacks = true,
        treesitter = true,
        which_key = true,
      },
    },
  },
  -- Tell LazyVim to use catppuccin
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}

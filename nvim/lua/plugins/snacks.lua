-- Override snacks.nvim to ensure rg (ripgrep) and fd are used explicitly,
-- and to enable the snacks file explorer.
return {
  "folke/snacks.nvim",
  opts = {
    -- Enable the snacks file explorer (sidebar tree)
    explorer = {
      enabled = true,
    },
    -- Picker: explicitly use fd for files, rg for grep
    picker = {
      enabled = true,
      sources = {
        files = {
          cmd = "fd",
          args = { "--type", "f", "--hidden", "--follow", "--exclude", ".git" },
        },
        grep = {
          cmd = "rg",
        },
        grep_word = {
          cmd = "rg",
        },
      },
      -- Show hidden files by default in picker
      hidden = true,
      -- Follow symlinks
      follow = true,
    },
  },
}

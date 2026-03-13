return {
  "saghen/blink.cmp",
  opts = {
    completion = {
      ghost_text = { enabled = true },
    },
    keymap = {
      preset = "default",
      -- Tab accepts the ghost text / selected completion item
      ["<Tab>"] = { "accept", "fallback" },
      -- Enter just inserts a newline (dismisses without accepting)
      ["<CR>"] = { "fallback" },
    },
  },
}

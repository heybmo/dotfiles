-- coding.lua
-- Additional coding-related plugins.

local M = {
  "ray-x/lsp_signature.nvim",
  event = "VeryLazy",
  opts = {
    floating_window = true,
    hint_inline = true,
  },
  config = function(_, opts)
    local sig = require("lsp_signature")

    sig.setup(opts)
  end,
}

return M

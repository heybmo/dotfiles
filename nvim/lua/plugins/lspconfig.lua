local M = {
  "neovim/nvim-lspconfig",
  init = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    -- change a keymap
    keys[#keys + 1] = {
      "gD",
      ':lua require("telescope.builtin").lsp_definitions({ jump_type = "never" })<cr>',
      "Go to Definition Preview",
    }
  end,
}

return M

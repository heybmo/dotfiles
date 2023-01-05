local lsp = require('languages.lsp')

local M = {}

M.lsp = {
  on_attach = lsp.on_attach,
  capabilities = lsp.capabilities,
  flags = lsp.flags,
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },

      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

return M

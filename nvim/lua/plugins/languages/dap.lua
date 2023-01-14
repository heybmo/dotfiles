local lsp = require('plugins.languages.lsp')
local M = {}

M.lsp = {
  capabilities = lsp.capabilities,
  on_attach = lsp.on_attach,
  flags = lsp.flags,
}

return M
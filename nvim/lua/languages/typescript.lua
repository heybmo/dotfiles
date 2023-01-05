local lsp = require('languages.lsp')

local M = {}

M.lsp = {
  capabilities = lsp.capabilities,
  flags = lsp.flags,
  on_attach = lsp.on_attach,
  filetypes = { 'javascript', 'javascriptreact', 'javascript.tsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
  cmd = { 'typescript-language-server', '--stdio' },
}

return M


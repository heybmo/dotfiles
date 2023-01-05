local lsp = require('languages.lsp')

local M = {}

M.lsp = {
  capabilities = lsp.capabilities,
  flags = lsp.flags,
  on_attach = lsp.on_attach,
  cmd = { 'gopls', 'serve' },
   settings = {
     gopls = {
       analyses = {
         unused_params = true,
         shadow = true,
       },
       staticcheck = true,
     },
     staticcheck = true,
   },
}

return M


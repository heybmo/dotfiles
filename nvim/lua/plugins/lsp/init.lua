--@diagnostic disable: missing-fields
-- Set up language servers/lspconfig

return {
  require("plugins.lsp.lsp"),
  require("plugins.lsp.mason"),
}
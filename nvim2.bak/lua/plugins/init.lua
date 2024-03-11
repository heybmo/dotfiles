--@description: Plugins directory, exports all configured packages.

return {
  require("plugins.lsp"),
  require("plugins.coding"),
  require("plugins.editor"),
  require("plugins.ui"),
}

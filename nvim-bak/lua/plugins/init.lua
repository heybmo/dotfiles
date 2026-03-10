-- @module plugins/init.lua
-- @description Load all plugins for nvim

local M = {
  require("plugins.coding"),
  require("plugins.editor"),
  require("plugins.lsp"),
}

return M

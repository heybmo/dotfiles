-- @module grug_far.lua
-- @description Search/replace across multiple files
local M = {
  'MagicDuck/grug-far.nvim',
  config = function()
    require('grug-far').setup({
      -- options, see Configuration section below
      -- there are no required options atm
      -- engine = 'ripgrep' is default, but 'astgrep' can be specified
    });
  end
}

return M
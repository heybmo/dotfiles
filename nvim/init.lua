local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Load settings and plugins
local settings = require("settings")

-- When using VSCode Neovim plugin, don't load the plugins
if not vim.g.vscode then
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    })
  end

  vim.opt.rtp:prepend(lazypath)

  local lazy = require("lazy")

  lazy.setup("plugins", {})

  -- Set colorscheme. Installed colorschemes available in lua/plugins/ui/colorscheme.lua
  vim.cmd[[ colorscheme catppuccin ]]
end

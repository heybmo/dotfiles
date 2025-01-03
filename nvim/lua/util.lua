-- @module config/util.lua
-- @description Utility functions to use across this Neovim setup.
local M = {}

function M.get_project_root()
  local root_patterns = {
    ".git",
    ".clang-format",
    "pyproject.toml",
    "setup.py",
    "package.json",
    ".hg",
    ".svn",
    ".bzr",
    "Makefile",
    "project.clj",
    "go.mod",
  }
  local root_dir = vim.fs.dirname(vim.fs.find(root_patterns, { upward = true })[1])

  return root_dir
end

return M

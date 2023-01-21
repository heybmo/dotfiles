
local black = require('plugins.languages.efm.black')
local isort = require('plugins.languages.efm.isort')
local stylua = require('plugins.languages.efm.stylua')
local prettier = require('plugins.languages.efm.prettier')
local eslint = require('plugins.languages.efm.eslint')
local shellcheck = require('plugins.languages.efm.shellcheck')
local shfmt = require('plugins.languages.efm.shfmt')

local M = {
  init_options = { documentFormatting = true },
  settings = {
    rootMarkers = { '.git/', 'README.md', 'package.json', 'Makefile' },
    languages = {
      lua = stylua,
      python = { black, isort },
      typescript = { prettier, eslint },
      javascript = { prettier, eslint },
      yaml = { prettier },
      json = { prettier },
      html = { prettier },
      scss = { prettier },
      css = { prettier },
      markdown = { prettier },
      sh = { shellcheck, shfmt },
    }
  }
}

return M


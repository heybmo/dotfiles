local lsp = require("plugins.languages.lsp")
local black = require("plugins.languages.efm.black")
local isort = require("plugins.languages.efm.isort")
local stylua = require("plugins.languages.efm.stylua")
local prettier = require("plugins.languages.efm.prettier")
local eslint = require("plugins.languages.efm.eslint")
local shellcheck = require("plugins.languages.efm.shellcheck")
local shfmt = require("plugins.languages.efm.shfmt")
local staticcheck = require("plugins.languages.efm.staticcheck")
local goimports = require("plugins.languages.efm.goimports")
local go_vet = require("plugins.languages.efm.go_vet")

local languages = {
	lua = { stylua },
	python = { black, isort },
	typescript = { prettier, eslint },
	javascript = { prettier, eslint },
  go = { staticcheck, goimports, go_vet },
	yaml = { prettier },
	json = { prettier },
	html = { prettier },
	scss = { prettier },
	css = { prettier },
	markdown = { prettier },
	sh = { shellcheck, shfmt },
}

local M = {
	cmd = { "/opt/homebrew/bin/efm-langserver" },
	on_attach = lsp.on_attach,
	capabilities = lsp.capabilities,
	root_dir = vim.loop.cwd,
	init_options = { documentFormatting = true },
	filetypes = vim.tbl_keys(languages),
	settings = {
		rootMarkers = { ".git/", "README.md", "package.json", "Makefile" },
		lintDebounce = 100,
		languages = languages,
	},
}

return M

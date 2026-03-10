local M = {
	"neovim/nvim-lspconfig",
	dependencies = { "saghen/blink.cmp" },

	-- example using `opts` for defining servers
	opts = {
		servers = {
			bashls = {},
			clojure_lsp = {},
			gopls = {},
			jsonls = {},
			lua_ls = {},
			pyright = {
				settings = {
					pyright = {
						autoImportCompletion = true,
						reportMissingImports = true,
						exclude = { ".venv" },
						venvPath = "./.venv/",
						venv = ".venv",
					},
					python = {
						analysis = {
							autoSearchPaths = true,
							diagnosticMode = "openFilesOnly",
							useLibraryCodeForTypes = true,
							autoImportCompletions = true,
							typeCheckingMode = "off",
						},
					},
				},
			},
			sqlls = {},
		},
	},
	config = function(_, opts)
		local lspconfig = require("lspconfig")
		for server, conf in pairs(opts.servers) do
			-- passing config.capabilities to blink.cmp merges with the capabilities in your
			-- `opts[server].capabilities, if you've defined it
			conf.capabilities = require("blink.cmp").get_lsp_capabilities(conf.capabilities)
			lspconfig[server].setup(conf)
		end
	end,
}

return M

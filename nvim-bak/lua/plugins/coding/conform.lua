local prettier_conf = { "prettierd", "prettier", stop_after_first = true }

local M = {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			-- Conform will run multiple formatters sequentially
			python = { "isort", "black" },
			rust = { "rustfmt", lsp_format = "fallback" },
			javascript = prettier_conf,
			typescript = prettier_conf,
			jsx = prettier_conf,
			tsx = prettier_conf,
			go = { "gofmt", "goimports" },
			markdown = { "markdownfmt" },
		},
		format_on_save = {
			-- These options will be passed to conform.format()
			timeout_ms = 500,
			lsp_format = "fallback",
		},
	},
	config = function(_, opts)
		require("conform").setup(opts)

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				require("conform").format({ bufnr = args.buf })
			end,
		})
	end,
}

return M

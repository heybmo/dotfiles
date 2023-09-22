local M = {
	"folke/trouble.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	cmd = { "TroubleToggle", "Trouble" },
	opts = { use_diagnostic_signs = true },
	keys = {
		{
			"<leader>xx",
			"<cmd>TroubleToggle document_diagnostics<cr>",
			desc = "Document Diagnostics (Trouble)",
		},
		{
			"<leader>xX",
			"<cmd>TroubleToggle workspace_diagnostics<cr>",
			desc = "Workspace Diagnostics (Trouble)",
		},
	},
}

function M.config()
	require("trouble").setup({
		position = "bottom", -- position of the list can be: bottom, top, left, right
		height = 10, -- height of the trouble list when position is top or bottom
		width = 50, -- width of the list when position is left or right
		icons = true, -- use devicons for filenames
		mode = "workspace_diagnostics",
		auto_open = false,
		auto_preview = true,
		auto_close = true,
	})
end

return M

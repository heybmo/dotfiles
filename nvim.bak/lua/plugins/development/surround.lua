local M = {
	"echasnovski/mini.surround",
	event = "BufEnter",
	keys = { "cs" },
	opts = {
		mappings = {
			add = "csa", -- Add surrounding in Normal and Visual modes
			delete = "csd", -- Delete surrounding
			find = "csf", -- Find surrounding (to the right)
			find_left = "csF", -- Find surrounding (to the left)
			highlight = "csh", -- Highlight surrounding
			replace = "csr", -- Replace surrounding
			update_n_lines = "csn", -- Update `n_lines`
		},
	},
	config = function(_, opts)
		-- use gz mappings instead of s to prevent conflict with leap
		require("mini.surround").setup(opts)
	end,
}

return M

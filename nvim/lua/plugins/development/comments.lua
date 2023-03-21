-- comments
local M = {
	"echasnovski/mini.comment",
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	event = "VeryLazy",
	opts = {
		mappings = {
			-- Toggle comment (like `gcip` - comment inner paragraph) for both
			-- Normal and Visual modes
			comment = "gc",

			-- Toggle comment on current line
			comment_line = "gcc",

			-- Define 'comment' textobject (like `dgc` - delete whole comment block)
			textobject = "gc",
		},
		hooks = {
			pre = function()
				require("ts_context_commentstring.internal").update_commentstring({})
			end,
		},
	},
	config = function(_, opts)
		require("mini.comment").setup(opts)
	end,
}

return M

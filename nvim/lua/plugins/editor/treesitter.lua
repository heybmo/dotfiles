local M = {
	"nvim-treesitter/nvim-treesitter",
	build = "TSUpdate",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	lazy = false,
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = { "python", "clojure", "go", "lua", "java" },
			rainbow = {
				enable = true,
			},
			highlight = {
				enable = true,
			},
			autopairs = { enable = true },
			textobjects = {
				select = {
					enable = true,
					lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						["fo"] = "@function.outer",
						["fi"] = "@function.inner",
						["co"] = "@class.outer",
						["ci"] = "@class.inner",
						["bi"] = "@block.inner",
						["bo"] = "@block.outer",
					},
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						["]m"] = "@function.outer",
						["]]"] = "@class.outer",
					},
					goto_next_end = {
						["]M"] = "@function.outer",
						["]["] = "@class.outer",
					},
					goto_previous_start = {
						["[m"] = "@function.outer",
						["[["] = "@class.outer",
					},
					goto_previous_end = {
						["[M"] = "@function.outer",
						["[]"] = "@class.outer",
					},
				},
			},
		})
	end,
}

return M

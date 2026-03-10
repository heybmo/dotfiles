local M = {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-telescope/telescope-live-grep-args.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		"debugloop/telescope-undo.nvim",
	},
	lazy = "VeryLazy",
	config = function()
		local actions = require("telescope.actions")
		local file_picker_args = { "fd", "--type", "f", "--hidden", "--strip-cwd-prefix", "--exclude", ".git" }

		require("telescope").setup({
			defaults = {
				dynamic_preview_title = true,
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						height = 0.9,
						width = 0.7,
					},
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						case_mode = "smart_case",
						override_file_sorter = true,
					},
					live_grep_args = {
						auto_quoting = true,
					},
				},
				mappings = {
					i = {
						["<c-d>"] = actions.delete_buffer,
						["<esc>"] = actions.close,
						["<c-c>"] = false,
					},
					n = {
						["<c-d>"] = actions.delete_buffer,
						["db"] = actions.delete_buffer,
						["<esc>"] = actions.close,
					},
				},
				pickers = {
					buffers = {
						sort_lastused = true,
						sort_mru = true,
					},
					find_files = {
						find_command = file_picker_args,
					},
					git_files = {
						show_untracked = true,
						recurse_submodules = true,
						use_git_root = true,
					},
				},
			},
		})

		require("telescope").load_extension("fzf")
		require("telescope").load_extension("live_grep_args")
	end,
}

return M

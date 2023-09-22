-- Telescope plugin

local M = {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	event = "BufEnter",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-live-grep-args.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		"junegunn/fzf",
		"junegunn/fzf.vim",
		"nvim-telescope/telescope-fzf-native.nvim",
		"BurntSushi/ripgrep",
	},
}

local util = require("util")

function M.telescope(builtin, opts)
	local params = { builtin = builtin, opts = opts }
	return function()
		builtin = params.builtin
		opts = params.opts
		opts = vim.tbl_deep_extend("force", { cwd = util.get_root() }, opts or {})
		if builtin == "files" then
			if vim.loop.fs_stat((opts.cwd or vim.loop.cwd()) .. "/.git") then
				opts.show_untracked = true
				builtin = "git_files"
			else
				builtin = "find_files"
			end
		end
		require("telescope.builtin")[builtin](opts)
	end
end

M.keys = {
	{ "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
	{ "<leader>/", M.telescope("live_grep"), desc = "Find in Files (Grep)" },
	{ "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
	{ "<leader><space>", M.telescope("files"), desc = "Find Files (root dir)" },
	{ "<leader>bb", "<cmd>Telescope buffers<CR>", desc = "List open buffers" },
	{ "<leader>f.", "Telescope find_files", desc = "Find files from root" },
	{ "<leader>fF", M.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
	{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
	{ "<leader>ff", M.telescope("files"), desc = "Find Files (root dir)" },
	{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
	{ "<leader>fh", '<cmd>lua require("telescope.builtin").find_files({ cwd="~" })<CR>', desc = "Find From Home Dir" },
	{ "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
	{ "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
	{ "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
	{ "<leader>sG", M.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
	{ "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
	{ "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
	{ "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
	{ "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
	{ "<leader>sg", M.telescope("live_grep"), desc = "Grep (root dir)" },
	{ "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
	{ "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
	{ "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
	{ "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
	{ "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
	{ "<leader>st", "<cmd>Telescope builtin<cr>", desc = "Telescope" },
	{
		"<leader>ss",
		M.telescope("lsp_document_symbols", {
			symbols = {
				"Class",
				"Function",
				"Method",
				"Constructor",
				"Interface",
				"Module",
				"Struct",
				"Trait",
				"Field",
				"Property",
			},
		}),
		desc = "Goto Symbol",
	},
}

function M.config()
	local telescope = require("telescope")
	local actions = require("telescope.actions")
	local themes = require("telescope.themes")

	telescope.load_extension("live_grep_args")

	-- Credit to @awwalker
	local width_for_nopreview = function(_, cols, _)
		if cols > 200 then
			return math.floor(cols * 0.5)
		elseif cols > 110 then
			return math.floor(cols * 0.6)
		else
			return math.floor(cols * 0.75)
		end
	end

	local height_dropdown_nopreview = function(_, _, rows)
		return math.floor(rows * 0.7)
	end

	telescope.setup({
		prompt_prefix = "🔍 ",
		file_ignore_patterns = {
			-- 'docs/',
			"%.lock",
			"__pycache__/*",
			"%.sqlite3",
			"%.ipynb",
			"node_modules/*",
			-- '%.jpg',
			-- '%.jpeg',
			-- '%.png',
			"%.svg",
			"%.otf",
			"%.ttf",
			"%.webp",
			".dart_tool/",
			-- '.settings/',
			-- '.vscode/',
			"__pycache__/",
			-- 'build/',
			-- 'env/',
			"gradle/",
			"%.pdb",
			"%.dll",
			"%.class",
			"%.exe",
			"%.cache",
			"%.ico",
			"%.pdf",
			"%.dylib",
			"%.jar",
			"%.docx",
			"%.met",
			"smalljre_*/*",
			".vale/",
			"%.burp",
			"%.mp4",
			"%.mkv",
			"%.rar",
			"%.zip",
			"%.7z",
			"%.tar",
			"%.bz2",
			"%.epub",
			"%.flac",
			"%.tar.gz",
		},
		set_env = { ["COLORTERM"] = "truecolor" },
		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,

				["<C-b>"] = actions.results_scrolling_up,
				["<C-f>"] = actions.results_scrolling_down,

				["<C-c>"] = actions.close,

				["<Down>"] = actions.move_selection_next,
				["<Up>"] = actions.move_selection_previous,

				["<CR>"] = actions.select_default,
				["<C-s>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,
				["<C-t>"] = actions.select_tab,
				["<C-d>"] = actions.delete_buffer,
			},
			n = {
				["<esc>"] = actions.close,
				["<CR>"] = actions.select_default,
				["j"] = actions.move_selection_next,
				["k"] = actions.move_selection_previous,
				["H"] = actions.move_to_top,
				["M"] = actions.move_to_middle,
				["L"] = actions.move_to_bottom,
				["q"] = actions.close,
				["dd"] = require("telescope.actions").delete_buffer,
				["s"] = actions.select_horizontal,
				["v"] = actions.select_vertical,
				["t"] = actions.select_tab,

				["<Down>"] = actions.move_selection_next,
				["<Up>"] = actions.move_selection_previous,
				["gg"] = actions.move_to_top,
				["G"] = actions.move_to_bottom,

				["<C-u>"] = actions.preview_scrolling_up,
				["<C-d>"] = actions.preview_scrolling_down,

				["<PageUp>"] = actions.results_scrolling_up,
				["<PageDown>"] = actions.results_scrolling_down,

				["?"] = actions.which_key,
			},
		},
		extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "ignore_case", -- or 'ignore_case' or 'respect_case' or 'smart_case'
			},
			live_grep_args = {},
			["ui-select"] = {
				themes.get_cursor({}),
			},
		},
		pickers = {
			buffers = {
				previewer = false,
				sort_lastused = true,
				sort_mru = true,
				show_all_buffers = true,
				layout_config = {
					width = width_for_nopreview,
					height = height_dropdown_nopreview,
				},
				mappings = {
					n = {
						["<c-d>"] = actions.delete_buffer,
					},
				},
			},
			find_files = {
				find_command = { "fd", "--type=f", "--glob", "--hidden", "--strip-cwd-prefix" },
			},
			lsp_code_actions = {
				theme = "cursor",
				previewer = false,
				layout_config = {
					width = width_for_nopreview,
					height = height_dropdown_nopreview,
				},
			},
		},
	})
end

return M

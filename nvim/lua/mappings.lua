-- VIM-WIDE MAPPINGS
local wk = require("which-key")

local function map(mode, shortcut, command)
	vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

local function nmap(shortcut, command)
	map("n", shortcut, command)
end

local function imap(shortcut, command)
	map("i", shortcut, command)
end

local function vmap(shortcut, command)
	map("v", shortcut, command)
end

local function cmap(shortcut, command)
	map("c", shortcut, command)
end

local function tmap(shortcut, command)
	map("t", shortcut, command)
end

local function nunmap(shortcut)
	vim.api.nvim_del_keymap(shortcut)
end

-----------------------------------------------------------------
-- VISUAL MODE MAPPING TABLE

local wk_visual_opts = {
	mode = "v",
}

local visual_keymaps = {
	c = { '"d', "Cut" },
	-- d = {'"_d', 'Delete without yanking' },
	-- p = {'"_dP', 'paste replace visual selection WITHOUT copying it'}
	[","] = {
		name = "+code actions",
		r = { "<cmd>lua vim.lsp.buf.range_formatting()<CR>", "Format range" },
	},
}

wk.register(visual_keymaps, wk_visual_opts)

----------------------------------------------------------------
-- NORMAL MODE MAPPING TABLE
local wk_normal_opts = {
	mode = "n",
}

-- 1 arg == description only
-- 2 args == remap + description
local normal_keymaps = {
	-- Mappings for ',' and 'g' in plugins/lsp.lua
	[","] = {
		name = "+diagnostic/language actions",
		d = { vim.diagnostic.open_float, "create floating window for diagnostics" },
		p = { vim.diagnostic.goto_prev, "go to previous diagnostic" },
		n = { vim.diagnostic.goto_next, "go to next diagnostic" },
		l = { vim.diagnostic.setloclist, "diagnostic location list" },
		["="] = {
			["="] = { "<cmd>lua (function() vim.lsp.buf.format { async = true } end)()<CR>", "format buffer" },
		},
	},
	g = {
		name = "+code actions",
		c = { "comment/uncomment line" },
		d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "go to definition" },
		D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "go to declaration" },
		f = { "<cmd>lua (function() vim.lsp.buf.format { async = true } end)()<CR>", "format buffer" },
		i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "go to implementation" },
		r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "rename" },
		s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "signature help" },
		t = {
			name = "type",
			d = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Go to type definition" },
		},
	},
	["<leader>"] = {
		["<Left>"] = { "<cmd>:bp<CR>", "Previous Buffer" },
		["<Right>"] = { "<cmd>:bn<CR>", "Next Buffer" },
		["/"] = { "<cmd>Telescope grep_string<CR>", "Search for code match" },
		["<Tab>"] = { "<C-^><CR>", "Toggle between buffers" },
		b = {
			name = "+buffer",
			b = { "<cmd>Telescope buffers<CR>", "Show buffers using Telescope" },
			d = { "<cmd>bd<CR>", "Delete the current buffer" },
			D = { "<cmd>BufOnly<CR>", "Delete all other buffers" },
			n = { "<cmd>bn<CR>", "Next Buffer" },
			p = { "<cmd>bp<CR>", "Previous Buffer" },
		},
		c = {
			name = "+change",
			d = { "<cmd>lcd %:h<CR>", "Change to current directory" },
		},
		f = {
			name = "+file/filetree",
			e = {
				d = { "<cmd>edit ~/dotfiles/nvim/init.lua<CR>", "Edit nvim config" },
				s = { "<cmd>edit ~/dotfiles/.zshrc<CR>", "Edit default shell config (.zshrc)" },
				n = { "<cmd>edit ~/notes<CR>", "Edit notes, write scratch" },
			},
			f = { "<cmd>Telescope find_files<CR>", "Find file using Telescope" },
			g = {
				"<cmd>Telescope.extensions.live_grep_args.live_grep_args()<CR>",
				"Find File using Telescope + flag args",
			},
			h = { "<cmd>Telescope help_tags<CR>", "Telescope help tags" },
			r = { "<cmd>NERDTreeFind<CR>", "Focus file tree on current buffer" },
			t = { "<cmd>NERDTreeToggle<CR>", "Toggle NERDTree" },
			z = {
				f = { "<cmd>FZF<CR>", "Find file using FZF" },
				h = { "<cmd>FZF ~/<CR>", "Find file from home dir" },
				r = { "<cmd>FZF /<CR>", "Find file from root" },
			},
		},
		r = {
			name = "+ripgrep",
			g = { "<cmd>Rg<CR>", "Find using Ripgrep" },
		},
		q = {
			name = "+quit/clear",
			h = { "<cmd>:noh<CR>", "Clear highlights until next search" },
			q = { "<cmd>qa<CR>", "Quit all, abort for unsaved files" },
			["!"] = { "<cmd>q!<CR>", "Quit all, forcefully." },
		},
		s = {
			name = "+set",
			c = { ":set colorcolumn=80<CR>", "Set visual column at col 80" },
			C = { ":set colorcolumn=<CR>", "Clear an existing visual column(s)" },
		},
		p = {
			name = "+projects",
			f = {
				'<cmd>lua require("telescope.builtin").find_files( { cwd = vim.fn.FindRootDirectory() })',
				"Find files in project",
			},
			g = { '<cmd>lua require("telescope.builtin").git_commits()<CR>', "List git commits" },
		},
		w = {
			name = "+window",
			["<Right>"] = { "<C-w><Right>", "Go to window on the right" },
			["<Left>"] = { "<C-w><Left>", "Go to window on the left" },
			["<Up>"] = { "<C-w><Up>", "Go to window above" },
			["<Down>"] = { "<C-w><Down>", "Go to window below" },
			["]"] = { "<C-w>>", "Increase window size" },
			["["] = { "<C-w><", "Decrease window size" },
			["+"] = { "<C-w>+", "Increase window size" },
			["-"] = { "<C-w>-", "Decrease window size" },
			d = { "<cmd>bd<CR>", "Delete current window" },
			h = { "<C-w><Left>", "Go to window on the left" },
			l = { "<C-w><Right>", "Go to window on the right" },
			j = { "<C-w><Down>", "Go to window below" },
			k = { "<C-w><Up>", "Go to window above" },
			s = { "<C-w>x", "Swap window with next one" },
			["<TAB>"] = { "<C-^><CR>", "Toggle between buffers" },
		},
		x = {
			name = "+code diagnostics",
			x = { "<cmd>TroubleToggle<CR>", "Toggle Trouble list" },
			f = { "<cmd>TroubleToggle quickfix<CR>", "Attempt to quick-fix an issue" },
		},
	},
	-- c = {'"d', 'Cut' },
	-- d = {
	--   d = {'"_d', 'Delete without yanking' },
	-- }
}

wk.register(normal_keymaps, wk_normal_opts)

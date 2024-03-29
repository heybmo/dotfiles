local M = {
	"goolord/alpha-nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	event = "VimEnter",
}

function M.opts()
	local dashboard = require("alpha.themes.dashboard")
	local logo = {
		[[                    ,/                  ]],
		[[                  ,'/                   ]],
		[[                ,' /                    ]],
		[[              ,'  /_____,               ]],
		[[             ,____    ,'                ]],
		[[                 /  ,'                  ]],
		[[                / ,'                    ]],
		[[               /,'                      ]],
		[[              /'                        ]],
	}

	dashboard.section.header.val = logo
	dashboard.section.buttons.val = {
		dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
		dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
		dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
		dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
		dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
		dashboard.button("s", "勒" .. " Restore Session", [[:lua require('persistence').load() <cr>]]),
		dashboard.button("l", "鈴" .. " Lazy", ":Lazy<CR>"),
		dashboard.button("q", " " .. " Quit", ":qa<CR>"),
	}
	for _, button in ipairs(dashboard.section.buttons.val) do
		button.opts.hl = "AlphaButtons"
		button.opts.hl_shortcut = "AlphaShortcut"
	end
	dashboard.section.footer.opts.hl = "Type"
	dashboard.section.header.opts.hl = "AlphaHeader"
	dashboard.section.buttons.opts.hl = "AlphaButtons"
	dashboard.opts.layout[1].val = 8
	return dashboard
end

function M.config(_, dashboard)
	vim.b.miniindentscope_disable = true

	-- close Lazy and re-open when the dashboard is ready
	if vim.o.filetype == "lazy" then
		vim.cmd.close()
		vim.api.nvim_create_autocmd("User", {
			pattern = "AlphaReady",
			callback = function()
				require("lazy").show()
			end,
		})
	end

	require("alpha").setup(dashboard.opts)

	vim.api.nvim_create_autocmd("User", {
		pattern = "LazyVimStarted",
		callback = function()
			local stats = require("lazy").stats()
			local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
			dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
			pcall(vim.cmd.AlphaRedraw)
		end,
	})
end

return M

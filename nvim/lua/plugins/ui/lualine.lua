local icons = require("plugins.ui.icons")

local M = {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"SmiteshP/nvim-navic",
		"folke/noice.nvim",
	},
}

local function fg(name)
	return function()
		---@type {foreground?:number}?
		local hl = vim.api.nvim_get_hl_by_name(name, true)
		return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
	end
end

function M.config()
	local lualine = require("lualine")

	lualine.setup({
		options = {
			icons_enabled = true,
			theme = "auto",
			disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch" },
			lualine_c = {
				{
					"diagnostics",
					symbols = {
						error = icons.diagnostics.Error,
						warn = icons.diagnostics.Warn,
						info = icons.diagnostics.Info,
						hint = icons.diagnostics.Hint,
					},
				},
				{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
				{ "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
        -- stylua: ignore
        {
          function() return require('nvim-navic').get_location() end,
          cond = function() return package.loaded['nvim-navic'] and require('nvim-navic').is_available() end,
        },
			},
			lualine_x = {
        -- stylua: ignore
        {
          function() return require('noice').api.status.command.get() end,
          cond = function() return package.loaded['noice'] and require('noice').api.status.command.has() end,
          color = fg('Statement')
        },
        -- stylua: ignore
        {
          function() return require('noice').api.status.mode.get() end,
          cond = function() return package.loaded['noice'] and require('noice').api.status.mode.has() end,
          color = fg('Constant'),
        },
				{ require("lazy.status").updates, cond = require("lazy.status").has_updates, color = fg("Special") },
				{
					"diff",
					symbols = {
						added = icons.git.added,
						modified = icons.git.modified,
						removed = icons.git.removed,
					},
				},
			},
			lualine_y = {
				{ "progress", separator = "", padding = { left = 1, right = 0 } },
				{ "location", padding = { left = 0, right = 1 } },
			},
			lualine_z = {
				function()
					return " " .. os.date("%R")
				end,
			},
		},
	})
end

return M

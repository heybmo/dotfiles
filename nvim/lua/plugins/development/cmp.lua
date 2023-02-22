local M = {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lua",
		"L3MON4D3/LuaSnip",
		"onsails/lspkind-nvim",
		"saadparwaiz1/cmp_luasnip",
		"rafamadriz/friendly-snippets",
    "Olical/conjure",
	},
}

function M.config()
	local cmp = require("cmp")
	require("luasnip")
	local lspkind = require("lspkind")

	require("luasnip/loaders/from_vscode").lazy_load()

	cmp.setup({
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		experimental = {
			ghost_text = true,
		},
		window = {
			completion = {
				border = "rounded",
				winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
			},
			documentation = cmp.config.window.bordered(),
		},
		view = {
			entries = "native",
		},

		mapping = {
			["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
			["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
			["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
			["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
			["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
			["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
			["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
			["<CR>"] = cmp.mapping.confirm({ select = true }),
			-- ['<Right>'] = cmp.mapping.confirm { select = true },
			-- ["<Tab>"] = cmp.mapping(function(fallback)
			-- if cmp.visible() then
			--   cmp.select_next_item()
			-- elseif luasnip.expand_or_jumpable() then
			--   luasnip.expand_or_jump()
			-- else
			--   fallback()
			-- end
			-- end, { "i", "s" }),

			-- ["<S-Tab>"] = cmp.mapping(function(fallback)
			-- if cmp.visible() then
			--   cmp.select_prev_item()
			-- elseif luasnip.jumpable(-1) then
			--   luasnip.jump(-1)
			-- else
			--   fallback()
			-- end
			-- end, { "i", "s" }),
		},

		formatting = {
			fields = { "kind", "abbr", "menu" },
			format = lspkind.cmp_format({
				with_text = true,
				-- mode = 'symbol_text', -- show only symbol annotations
				-- maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
				menu = {
					buffer = "[Buffer]",
					nvim_lsp = "[LSP]",
					luasnip = "[LuaSnip]",
					nvim_lua = "[Lua]",
					latex_symbols = "[Latex]",
				},
			}),
		},

		sources = cmp.config.sources({
      {name = 'conjure'},
			{ name = "vim-dadbod-completion" },
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			{ name = "buffer" },
		}),
	})
end

return M

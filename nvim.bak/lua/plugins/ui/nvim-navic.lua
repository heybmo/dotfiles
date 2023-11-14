-- Statusline component to show code context
local on_attach = function(on_attach)
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local buffer = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			on_attach(client, buffer)
		end,
	})
end

local M = {
	"SmiteshP/nvim-navic",
  dependencies = {"neovim/nvim-lspconfig"},
	init = function()
		vim.g.navic_silence = true
		on_attach(function(client, buffer)
			if client.server_capabilities.documentSymbolProvider then
				require("nvim-navic").attach(client, buffer)
			end
		end)
	end,
	opts = { separator = " ", highlight = true, depth_limit = 5 },
}

return M

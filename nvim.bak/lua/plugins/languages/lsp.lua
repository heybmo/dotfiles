local keymap = require("vim.keymap")

local M = {}

M.setup = function()
	vim.fn.sign_define("LspDiagnosticsSignError", { text = "✘" })
	vim.fn.sign_define("LspDiagnosticsSignWarning", { text = "" })
	vim.fn.sign_define("LspDiagnosticsSignInformation", { text = "" })
	vim.fn.sign_define("LspDiagnosticsSignHint", { text = "" })

	vim.diagnostic.config({
		-- Show diagnostic message using virtual text.
		virtual_text = false,
		-- Show a sign next to the line with a diagnostic.
		signs = true,
		-- Update diagnostics while editing in insert mode.
		update_in_insert = true,
		-- Use an underline to show a diagnostic location.
		underline = true,
		-- Order diagnostics by severity.
		severity_sort = false,
		-- Show diagnostic messages in floating windows.
		float = {
			border = "rounded",
			source = "always",
			-- header = '',
			-- prefix = '',
			-- Credit: https://github.com/jessarcher/dotfiles/blob/master/nvim/lua/user/plugins/lspconfig.lua
			format = function(diagnostic)
				if diagnostic.user_data ~= nil and diagnostic.user_data.lsp.code ~= nil then
					return string.format("%s: %s", diagnostic.user_data.lsp.code, diagnostic.message)
				end
				return diagnostic.message
			end,
		},
	})

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
		close_events = { "BufHidden", "InsertLeave" },
	})

	-- Automatically show diagnostics in hover window
	-- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization#show-line-diagnostics-automatically-in-hover-window
	-- vim.cmd [[autocmd! CursorHold,CursorHoldI * lua if vim.api.nvim_get_mode()['mode'] == 'n' then vim.diagnostic.open_float(nil, {focus=false}) end]]
end

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
keymap.set("n", ",d", vim.diagnostic.open_float, opts)
keymap.set("n", ",p", vim.diagnostic.goto_prev, opts)
keymap.set("n", ",n", vim.diagnostic.goto_next, opts)
keymap.set("n", ",l", vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
function M.on_attach(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	keymap.set("n", "gK", vim.lsp.buf.hover, bufopts)
	keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	keymap.set("n", "gS", vim.lsp.buf.signature_help, bufopts)
	keymap.set("n", "rn", vim.lsp.buf.rename, bufopts)
	keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	keymap.set("n", "gtd", vim.lsp.buf.type_definition, bufopts)
	keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
	keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	-- keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	keymap.set("n", "gr", ":Telescope lsp_references", bufopts)
	keymap.set("n", "<space>f", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)
end

M.flags = {
	-- This is the default in Nvim 0.7+
	debounce_text_changes = 150,
}

-- DEPRECATED but keeping for reference
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
M.capabilities = require("cmp_nvim_lsp").default_capabilities({})

return M

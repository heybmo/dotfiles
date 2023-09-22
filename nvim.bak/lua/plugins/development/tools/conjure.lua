local M = {
	"Olical/conjure",
  dependencies = {
    'tpope/vim-dispatch',
    'clojure-vim/vim-jack-in',
    'radenling/vim-dispatch-neovim'
  },
	event = "BufEnter *.clj",
}

function M.config()
	require("conjure").setup()

	local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
	vim.api.nvim_create_autocmd("BufWritePre", {
		pattern = "*.go",
		callback = function()
			require("go.format").goimport()
		end,
		group = format_sync_grp,
	})
end

return M

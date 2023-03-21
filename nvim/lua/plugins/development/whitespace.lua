local M = {
	"ntpeters/vim-better-whitespace",
}

function M.config()
	vim.g.strip_max_file_size = 1000
end

return M

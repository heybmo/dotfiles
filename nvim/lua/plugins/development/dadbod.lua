local M = {
	"tpope/vim-dadbod",
}

function M.config()
	vim.g.dbs = {
		{ name = "core - postgres@localhost" },
		{ url = "jdbc:postgresql://localhost:5432/postgres" },
	}
end

return M

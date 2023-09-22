local M = {
	"rcarriga/nvim-dap-ui",
	dependencies = { "mfussenegger/nvim-dap" },
}

function M.config()
	require("dapui").setup({})
end

return M

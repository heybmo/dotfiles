local M = {
	"ray-x/lsp_signature.nvim",
	event = "BufEnter",
	config = function()
		Signature = require("lsp_signature")

		Signature.setup({
			bind = true,
      floating_window = false,
      floating_window_above_cur_line = false,
      floating_window_off_x = 5,
      floating_window_off_y = 0,
			handler_opts = {
				border = "rounded",
			},
      hint_enable = true,
      toggle_key = '<M-x>',
		})

		Signature.status_line(79)
	end,
}

return M

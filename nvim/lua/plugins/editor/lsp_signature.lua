local M = {
  'ray-x/lsp_signature.nvim',
  event = 'BufEnter',
  config = function()
    Signature = require('lsp_signature')

    Signature.setup({
      bind = true,
      handler_opts = {
        border = 'rounded',
      }
    })

    Signature.status_line(79)
  end,
}

return M

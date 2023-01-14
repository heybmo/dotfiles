local M = {
  'windwp/nvim-autopairs',
  dependencies = {
    'hrsh7th/nvim-cmp',
  },
  lazy = false,
}

function M.config()
  local cmp_autopairs = require('nvim-autopairs')
  local cmp_autocompletion = require('nvim-autopairs.completion.cmp')
  local cmp = require('cmp')

  cmp_autopairs.setup({})

  cmp.event:on(
    'confirm_done',
    cmp_autocompletion.on_confirm_done()
  )
end

return M


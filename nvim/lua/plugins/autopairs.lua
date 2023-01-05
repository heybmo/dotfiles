local cmp_autopairs = require('nvim-autopairs')
local cmp_autocompletion = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')

cmp_autopairs.setup({})

cmp.event:on(
  'confirm_done',
  cmp_autocompletion.on_confirm_done()
)

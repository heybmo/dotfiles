local M = {
  'windwp/nvim-ts-autotag',
}


function M.config()
  local autotag = require('nvim-ts-autotag')
  autotag.setup({})
end

return M


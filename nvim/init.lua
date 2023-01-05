require('plugins')
require('settings')

-- Bufonly before mappings since we have
-- a mapping that uses the function.
require('scripts.bufonly')

require('impatient')
require('plugins.cmp')
require('plugins.neoscroll')
require('plugins.autopairs')
require('plugins.autotag')
require('plugins.treesitter')
require('plugins.telescope')
require('plugins.dadbod')
require('plugins.mason')
require('plugins.lualine')
require('plugins.bufferline')
require('plugins.alpha')
require('plugins.go-nvim')
require('plugins.trouble')
require('plugins.whichkey')
require('plugins.dap-ui')
require('plugins.doge')
require('plugins.neorg')

require('languages')

require('mappings')

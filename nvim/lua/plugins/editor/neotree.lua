--
local M = {
  'nvim-neo-tree/neo-tree.nvim',
  cmd = 'Neotree',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
  },
  keys = {
    {
      '<leader>ft',
      function()
        require('neo-tree.command').execute({
          toggle = true, dir = require('util').get_root
        })
      end,
      desc = 'Explorer NeoTree (root dir)',
    },
    { '<leader>fT', '<cmd>Neotree toggle<CR>', desc = 'Explorer NeoTree (cwd)' },
    { '<leader>fe', '<leader>fe', desc = 'Explorer NeoTree (root dir)', remap = true },
    { '<leader>fE', '<leader>fE', desc = 'Explorer NeoTree (cwd)', remap = true },
  },
  opts = {
    filesystem = {
      follow_current_file = true,
    },
    -- For git_status
    -- default_component_configs = {
    --   symbols = {
    --     -- Change type
    --     added     = "✚",
    --     deleted   = "✖",
    --     modified  = "",
    --     renamed   = "",
    --     -- Status type
    --     untracked = "",
    --     ignored   = "",
    --     unstaged  = "",
    --     staged    = "",
    --     conflict  = "",
    --   }
    -- }
  },
}

function M.init()
  vim.g.neo_tree_remove_legacy_commands = 1
  if vim.fn.argc() == 1 then
    local stat = vim.loop.fs_stat(vim.fn.argv(0))
    if stat and stat.type == 'directory' then
      require('neo-tree')
    end
  end
end

function M.config()
  require('neo-tree').setup({
    enable_git_status = true,
    enable_diagnostics = true,
  })
end

return M

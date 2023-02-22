local M = {
	"echasnovski/mini.bufremove",
    -- stylua: ignore
    keys = {
      {
        '<leader>bd',
        function() require('mini.bufremove').delete(0, false) end,
        desc = 'Delete Buffer'
      },
      {
        '<leader>ba',
        function()
          require('scripts.bufonly')
          vim.cmd([[ BufOnly ]])
        end,
        desc = 'Delete all other buffers'
      },
      {
        '<leader>bD',
        function() require('mini.bufremove').delete(0, true) end,
        desc = 'Delete Buffer (Force)'
      },
    },
}

return M

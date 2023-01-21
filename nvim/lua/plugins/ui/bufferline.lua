local M = {
  'akinsho/bufferline.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  },
  event = 'BufEnter',
  init = function()
    vim.keymap.set('n', '<s-h>', '<cmd>BufferLineCyclePrev<cr>', { desc = 'Prev Buffer' })
    vim.keymap.set('n', '<s-l>', '<cmd>BufferLineCycleNext<cr>', { desc = 'Next Buffer' })
    vim.keymap.set('n', '<leader>b[', '<cmd>BufferLineCyclePrev<cr>', { desc = 'Previous' })
    vim.keymap.set('n', '<leader>b]', '<cmd>BufferLineCycleNext<cr>', { desc = 'Next' })
  end,
}

function M.config()
  require('bufferline').setup({
    options = {
      always_show_bufferline = false,
      color_icons = true,
      diagnostics = 'nvim_lsp',
      hover = {
        enable = true,
        reveal = { 'close' },
      },
      diagnostics_indicator = function(_, _, diag)
        local icons = require('plugins.ui.icons').diagnostics
        local ret = (diag.error and icons.Error .. diag.error .. ' ' or '')
            .. (diag.warning and icons.Warn .. diag.warning or '')
        return vim.trim(ret)
      end,
      offsets = {
        {
          filetype = 'neo-tree',
          text = 'Neo-tree',
          highlight = 'Directory',
          text_align = 'left',
        },
      },
      show_buffer_close_icons = true,
      show_buffer_icons = true,
      show_tab_indicators = true,
      show_duplicate_prefix = true,
      separator_style = 'thick',
    },
  })
end

return M

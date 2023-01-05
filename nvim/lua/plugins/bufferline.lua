require('bufferline').setup({
  options = {
    always_show_bufferline = true,
    color_icons = true,
    diagnostics = 'nvim_lsp',
    hover = {
      enable = true,
      reveal = {'close'},
    },
    numbers = function(opts)
      return string.format('%s|%s', opts.id, opts.raise(opts.ordinal))
    end,
    show_buffer_close_icons = true,
    show_buffer_icons = true,
    show_tab_indicators = true,
    show_duplicate_prefix = true,
    separator_style = 'thick',
  },
})

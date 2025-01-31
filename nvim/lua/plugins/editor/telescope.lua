local M = {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-live-grep-args.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "debugloop/telescope-undo.nvim",
  },
  lazy = 'VeryLazy',
  config = function()
    local actions = require('telescope.actions')

    require('telescope').setup({
      defaults = {
        dynamic_preview_title = true,
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            case_mode = 'smart_case',
            override_file_sorter = true,
          },
          live_grep_args = {
            auto_quoting = true,
          },
        },
        mappings = {
          i = {
            ["<c-d>"] = actions.delete_buffer,
          },
          n = {
            ["<c-d>"] = actions.delete_buffer,
            ["dd"] = actions.delete_buffer,
          },
        },
        pickers = {
          buffers = {
            sort_lastused = true,
            sort_mru = true,
          },
        },
      },
    })

    require('telescope').load_extension('fzf')
  end,
}

return M

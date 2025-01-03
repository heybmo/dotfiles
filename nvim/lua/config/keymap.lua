local wk = require("which-key")
local util = require("util")

wk.add({
  mode = {"n", "v"},
  -- FILES / DIRECTORIES
  { "<leader>f", group = "(F)iles" },
  { "<leader>ft", "<cmd>Neotree toggle<cr>", desc = "Toggle Neotree" },

  -- WINDOW / WINDOW MANAGEMENT
  { "<leader>w", group = "(W)indows" },
  {
    "<leader>wa",
    function()
      require('window-picker').pick_window({
        hint = 'floating-big-letter'
      })
    end,
    desc = "Show all windows and pick one",
  },
  { "<leader>wh", "<C-w>h", desc = "Go to left window", },
  { "<leader>wl", "<C-w>l", desc = "Go to right window", },
  { "<leader>wj", "<C-w>j", desc = "Go to bottom window", },
  { "<leader>wk", "<C-w>k", desc = "Go to top window", }
})


local builtin = require('telescope.builtin')

wk.add({
  mode = {"n", "v"},
  { "<leader>ff", builtin.find_files, desc = "Find files" },
  { "<leader>/", builtin.live_grep, desc = "Run live grep on files" },
  { "<leader>bb", builtin.buffers, desc = "Show all buffers" },
})

local grugfar = require('grug-far')

wk.add({
  {
    "<leader>fr",
    function()
      grugfar.with_visual_selection({
      prefills = { paths = vim.fn.expand("%") },
    }) end,
    desc = "Find and replace in current file",
  },
  {
    "<leader>fR",
    function()
      grugfar.with_visual_selection({
        prefills = { paths = util.get_project_root() },
      })
    end,
    desc = "Find and replace in current project",
  },
})

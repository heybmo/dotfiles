local wk = require("which-key")
local Snacks = require("snacks")
local builtin = require("telescope.builtin")
local tel_actions = require("telescope.actions")
local grugfar = require("grug-far")
local util = require("util")
local blink = require('blink.cmp')

-- NORMAL AND VISUAL MODES
wk.add({
  mode = { "n", "v" },

  -- WINDOW / WINDOW MANAGEMENT
  { "<leader>w", group = "(W)indows" },
  {
    "<leader>wa",
    function()
      require("window-picker").pick_window({
        hint = "floating-big-letter",
      })
    end,
    desc = "Show all windows and pick one",
  },
  {
    "<leader>wh",
    "<C-w>h",
    desc = "Go to left window",
  },
  {
    "<leader>wl",
    "<C-w>l",
    desc = "Go to right window",
  },
  {
    "<leader>wj",
    "<C-w>j",
    desc = "Go to bottom window",
  },
  {
    "<leader>wk",
    "<C-w>k",
    desc = "Go to top window",
  },
  {
    "<leader>wv",
    "<cmd>vsplit<cr>",
    desc = "Split window vertically",
  },
  {
    "<leader>w|",
    "<cmd>vsplit<cr>",
    desc = "Split window vertically",
  },
  {
    "<leader>w-",
    "<cmd>split<cr>",
    desc = "Split window horizontally",
  },


  -- BUFFERS
  { "<leader>b", group = "(B)uffers" },
  {
    "<leader>bb",
    builtin.buffers,
    desc = "Show all buffers",
  },
  {
    "<leader><tab>",
    "<cmd>b#<cr>",
    desc = "Toggle last buffer",
  },

  -- Goto/Git
  {
    "<leader>gB",
    function()
      Snacks.gitbrowse()
    end,
    desc = "Git Browse",
    mode = { "n", "v" },
  },
  {
    "<leader>gb",
    function()
      Snacks.git.blame_line()
    end,
    desc = "Git Blame Line",
  },
  {
    "<leader>gL",
    function()
      Snacks.lazygit()
    end,
    desc = "Lazygit",
  },
  {
    "gd",
    function()
      require("telescope.builtin").lsp_definitions({ reuse_win = true })
    end,
    desc = "Goto Definition",
  },
  {
    "gr",
    "<cmd>Telescope lsp_references<cr>",
    desc = "References",
    nowait = true,
  },
  {
    "gI",
    function()
      require("telescope.builtin").lsp_implementations({ reuse_win = true })
    end,
    desc = "Goto Implementation",
  },
  {
    "gy",
    function()
      require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
    end,
    desc = "Goto T[y]pe Definition",
  },
  {
    "<leader>gta",
    function()
      local enabled = require('blink.cmp.config').completion.auto_show
      require('blink.cmp.config').completion.auto_show = not enabled
    end,
    desc = "Toggle autocompletion help"
  },
  {
    "<leader>gts",
    function()
      local enabled = require('blink.cmp.config').signature.enabled
      require('blink.cmp.config').signature.enabled = not enabled
    end,
    desc = "toggle signature help"
  },

  -- FILES AND FINDING
  {
    "<leader>ff",
    function()
      builtin.find_files({ hidden = true, follow = true })
    end,
    desc = "Find files",
  },
  {
    "<leader>fF",
    function()
      builtin.find_files({
        search_dirs = {
          os.getenv("HOME"),
          hidden = true,
          follow = true,
          no_ignore = true,
        },
      })
    end,
    desc = "Find files from home directory",
  },
  {
    "<leader>/",
    builtin.live_grep,
    desc = "Run live grep on files",
  },
  { "<leader>f", group = "(F)iles" },
  {
    "<leader>fs",
    function()
      Snacks.scratch()
    end,
    desc = "Toggle Scratch Buffer",
  },
  {
    "<leader>fcr",
    function()
      Snacks.rename.rename_file()
    end,
    desc = "Rename current file",
  },
  {
    "<leader>ft",
    "<cmd>Neotree toggle<cr>",
    desc = "Toggle Neotree",
  },
  {
    "<leader>fr",
    function()
      grugfar.with_visual_selection({
        prefills = { paths = vim.fn.expand("%") },
      })
    end,
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

  -- PASTE/PUT/COPY/YANK
  {
    "p",
    "<Plug>(YankyPutAfter)",
    desc = "Paste",
    mode = { "n", "x" },
  },
  {
    "P",
    "<Plug>(YankyPutBefore)",
    desc = "Paste Before",
    mode = { "n", "x" },
  },
  {
    "y",
    "<Plug>(YankyYank)",
    mode = { "n", "x" },
    desc = "Yank text"
  },

  -- PROJECT
  { "<leader>p", group = "(P)roject" },
  {
    "<leader>pf",
    builtin.git_files,
    desc = "Find files in project",
  },

  -- NOTIFICATIONS
  { "<leader>n", group = "(N)otifications" },
  {
    "<leader>nh",
    function()
      Snacks.notifier.show_history()
    end,
    desc = "Notification History",
  },
  {
    "<leader>nd",
    function()
      Snacks.notifier.hide()
    end,
    desc = "Dismiss All Notifications",
  },

  -- MISC
  {
    "]]",
    function()
      Snacks.words.jump(vim.v.count1)
    end,
    desc = "Next Reference",
    mode = { "n", "t" },
  },
  {
    "[[",
    function()
      Snacks.words.jump(-vim.v.count1)
    end,
    desc = "Prev Reference",
    mode = { "n", "t" },
  },
})

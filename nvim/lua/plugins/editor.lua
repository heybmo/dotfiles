
local Util = require("util")

local M = {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
      require("which-key").register({
        ["<leader>"] = {
          f = {
            t = {
              function()
                require("neo-tree.command").execute({ toggle = true, dir = Util.get_root() })
              end,
              "Toggle NeoTree"
            },
          },
        },
      })
    end
  },
  -- Heavily borrowing from LazyVim
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.4',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        enabled = vim.fn.executable("make") == 1,
      },
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "debugloop/telescope-undo.nvim",

    },
    config = function()
      local wk = require("which-key")
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          -- open files in the first window that is an actual file.
          -- use the current window if no other window is available.
          get_selection_window = function()
            local wins = vim.api.nvim_list_wins()
            table.insert(wins, 1, vim.api.nvim_get_current_win())
            for _, win in ipairs(wins) do
              local buf = vim.api.nvim_win_get_buf(win)
              if vim.bo[buf].buftype == "" then
                return win
              end
            end
            return 0
          end,
        },
        extensions = {
          file_browser = {
            -- theme = "catppuccin",
            hijack_netrw = true,
          },
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "ignore_case", -- or "ignore_case" or "respect_case" or "smart_case"
          },
          live_grep_args = {
            auto_quoting = true,
          },
          ["ui-select"] = {
            require("telescope.themes").get_cursor({})
          }
        }
      })

      telescope.load_extension("file_browser")
      telescope.load_extension("live_grep_args")
      telescope.load_extension("ui-select")
      telescope.load_extension("undo")

      -- Set keys
      wk.register({
        ["<leader>"] = {
          ["/"] = {":lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>", "Grep from Root" },
          [":"] = { builtin.command_history, "Command History" },
          -- "(B)uffers"
          b = {
            b = {"<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", "Buffers"},
          },
          -- "(F)iles"
          f = {
            name = "+(f)ile",
            b = {":Telescope file_browser<CR>", "Browse files"},
            B = {":Telescope file_browser path=%:p:h select_buffer=true<CR>", "Browse files (from current buffer path)"},
            c = {function() builtin.find_files({cwd=telescope.utils.buffer_dir()}) end, "Find Files (Current Directory)"},
            f = {function() builtin.git_files({cwd=Util.get_root(), recurse_submodules=true}) end, "Find Files (Project Root)"},
            g = {
              c = {"<cmd>Telescope git_commits<CR>", "Git Commits"},
              s = {"<cmd>Telescope git_status<CR>", "Git Status"},
            },
            h = {builtin.help_tags, "Find help"},
            t = {}
          },
          -- (S)earch
          s = {
            name = "+(s)earch",
            a = {builtin.autocommands, "Autocommands"},
            b = {builtin.current_buffer_fuzzy_find, "Find in Buffer"},
            c = {"<cmd>Telescope command_history<cr>", "Command History"},
            d = {"<cmd>Telescope diagnostics bufnr=0<cr>", "Document Diagnostics"},
            D = {"<cmd>Telescope diagnostics<cr>", "Workspace Diagnostics"},
            k = {"<cmd>Telescope keymaps<cr>", "Keymaps"},
            s = {
              function()
                require("telescope.builtin").lsp_document_symbols({
                  symbols = require("lazyvim.config").get_kind_filter(),
                })
              end,
              "Goto Symbol"
            },
            S = {
              function()
                require("telescope.builtin").lsp_dynamic_workspace_symbols({
                  symbols = require("lazyvim.config").get_kind_filter(),
                })
              end,
              "Goto Symbol (Workspace)"
            },
            w = {function() builtin.grep_string({ word_match="-w", cwd=Util.get_root()}) end, "Search for Word (Project Dir)"},
            W = {function() builtin.grep_string({ word_match="-w" }) end, "Search for Word (Root Dir)"},
            ["?"] = {"<cmd>Telescope help_tags<cr>", "Help Pages"},
          },
        },
      }, {mode = {"n", "v"}})
    end
  },
  -- File Browser
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    }
  },
  {
    "anuvyklack/windows.nvim",
    dependencies = {
        "anuvyklack/middleclass",
        "anuvyklack/animation.nvim"
    },
    config = function()
        vim.o.winwidth = 10
        vim.o.winminwidth = 10
        vim.o.equalalways = false
        require('windows').setup()

        require("which-key").register({
          ["<leader>"] = {
            w = {
              name = "+window",
              ["<Right>"] = { "<C-w><Right>", "Go to window on the right" },
              ["<Left>"] = { "<C-w><Left>", "Go to window on the left" },
              ["<Up>"] = { "<C-w><Up>", "Go to window above" },
              ["<Down>"] = { "<C-w><Down>", "Go to window below" },
              ["]"] = { "<C-w>>", "Increase window size" },
              ["["] = { "<C-w><", "Decrease window size" },
              ["+"] = { "<C-w>+", "Increase window size" },
              ["-"] = { "<C-w>-", "Decrease window size" },
              d = { "<cmd>bd<CR>", "Delete current window" },
              h = { "<C-w><Left>", "Go to window on the left" },
              l = { "<C-w><Right>", "Go to window on the right" },
              j = { "<C-w><Down>", "Go to window below" },
              k = { "<C-w><Up>", "Go to window above" },
              m = { "<cmd>WindowsMaximize<cr>", "Toggle Maximization of Window" },
              n = { "<C-w>n", "New empty buffer" },
              s = { "<C-w>s", "Split horizontally" },
              v = { "<C-w>v", "Split window vertically" },
              ["="] = { "<cmd>WindowsEqualize<cr>", "Equalize all window sizes" },
              ["<TAB>"] = { "<C-^><CR>", "Toggle between buffers" },
            },
          }
        })
    end
  }
}

return M

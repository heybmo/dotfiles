--@description Coding-related plugins to make development easier. Mostly ripped from LazyVim.


local M = {
  -- snippets
  {
    "L3MON4D3/LuaSnip",
    build = (not jit.os:find("Windows"))
        and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
      or nil,
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    -- stylua: ignore
    keys = {
      {
        "<tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true, silent = true, mode = "i",
      },
      { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
      { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    version = false,
    event = { "VeryLazy" },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          "bash",
          "c",
          "clojure",
          "cpp",
          "css",
          "csv",
          "diff",
          "go",
          "html",
          "java",
          "javascript",
          "jq",
          "jsdoc",
          "json",
          "lua",
          "luadoc",
          "luap",
          "markdown",
          "markdown_inline",
          "make",
          "objc",
          "python",
          "query",
          "regex",
          "ruby",
          "rust",
          "sql",
          "swift",
          "toml",
          "typescript",
          "tsx",
          "yaml",
        },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
        textobjects = {
          move = {
            enable = true,
            goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
            goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
            goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
            goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
          },
        },
      })
    end
  },
  -- Show context of the current function
  {
    "nvim-treesitter/nvim-treesitter-context",
    enabled = true,
    opts = { mode = "cursor", max_lines = 3 },
    keys = {
      {
        "<leader>ut",
        function()
          local tsc = require("treesitter-context")
          tsc.toggle()
        end,
        desc = "Toggle Treesitter Context",
      },
      {
        "<leader>[c",
        function()
          local tsc = require("treesitter-context")
          tsc.go_to_context()
        end,
        desc = "Go to Context"
      }
    },
  },

  -- Automatically add closing tags for HTML and JSX
  {
    "windwp/nvim-ts-autotag",
    opts = {},
  },
  -- auto completion
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
    opts = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      local cmp = require("cmp")
      local defaults = require("cmp.config.default")()

			-- Options map to return
      return {
        completion = {
          completeopt = "menu,menuone,noinsert,longest",
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
				window = {
					completion    = cmp.config.window.bordered(),
    			documentation = cmp.config.window.bordered(),
				},
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
		  ["<Down>"] = cmp.mapping(
			cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
			{ "i", "c" }
		  ),
			-- Disable tab completion (for now)
			-- ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }), { "c" }),
			["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { "i", "c" }),
          ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<S-CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<C-CR>"] = function(fallback)
            cmp.abort()
            fallback()
          end,
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
        formatting = {
          format = function(_, item)
            local icons = {
              Array         = " ",
              Boolean       = "󰨙 ",
              Class         = " ",
              Codeium       = "󰘦 ",
              Color         = " ",
              Control       = " ",
              Collapsed     = " ",
              Constant      = "󰏿 ",
              Constructor   = " ",
              Copilot       = " ",
              Enum          = " ",
              EnumMember    = " ",
              Event         = " ",
              Field         = " ",
              File          = " ",
              Folder        = " ",
              Function      = "󰊕 ",
              Interface     = " ",
              Key           = " ",
              Keyword       = " ",
              Method        = "󰊕 ",
              Module        = " ",
              Namespace     = "󰦮 ",
              Null          = " ",
              Number        = "󰎠 ",
              Object        = " ",
              Operator      = " ",
              Package       = " ",
              Property      = " ",
              Reference     = " ",
              Snippet       = " ",
              String        = " ",
              Struct        = "󰆼 ",
              TabNine       = "󰏚 ",
              Text          = " ",
              TypeParameter = " ",
              Unit          = " ",
              Value         = " ",
              Variable      = "󰀫 ",
            }
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end
            return item
          end,
        },
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
        sorting = defaults.sorting,
      }
    end,
    ---@param opts cmp.ConfigSchema
    config = function(_, opts)
      for _, source in ipairs(opts.sources) do
        source.group_index = source.group_index or 1
      end
      require("cmp").setup(opts)
    end,
  },
  -- Show indent scope
  { 'echasnovski/mini.indentscope',
	version = '*',
	config = function()
	  require("mini.indentscope").setup()
	end
  },

  -- Better textobjects
  { 'echasnovski/mini.ai',
    version = '*',
	config = function()
	  require("mini.ai").setup()
	end},

  -- Move around with brackets
  { 'echasnovski/mini.bracketed',
    version = '*',
	config = function()
	  require("mini.bracketed").setup()
	end},

  -- Autopairs
  { 'echasnovski/mini.pairs',
    version = '*',
    config = function()
			require("mini.pairs").setup()
	end},

  -- Better surround actions
  { 'echasnovski/mini.surround',
	version = '*',
	config = function()
		require("mini.surround").setup()
	end},
}

return M

local M = {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    opts = {
      ensure_installed = {
        "python",
        "c",
        "javascript",
        "html",
        "typescript",
        "markdown",
        "clojure",
        "cmake",
        "css",
        "cpp",
        "go",
        "jq",
        "json",
        "lua",
        "yaml",
        "sql",
      },
      disable = function(lang, buf)
        -- Disable for HUGE files so nvim doesn't stall
        local max_filesize = 2000 * 1024 -- 2000 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
      highlight = {
        enabled = true,
      },
      pairs = {
        enable = true,
        highlight_self = false,
      },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
      enable = false,
      max_lines = 0,
      mode = 'topline',
    },
  },
}

return M

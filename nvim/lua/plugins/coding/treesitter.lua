local M = {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
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
        local max_filesize = 1000 * 1024 -- 1000 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
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

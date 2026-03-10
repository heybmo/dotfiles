local M = {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      "prettier",
      "prettierd",
      "stylua",
      "isort",
      "black",
      "rustfmt",
      "gofmt",
      "goimports",
      "markdownfmt",
    },
  },
}

return M

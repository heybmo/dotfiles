-- Options loaded before lazy.nvim startup
-- LazyVim sets sensible defaults; only override what differs.
-- See: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

local opt = vim.opt

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Line numbers: absolute only (no relative)
opt.number = true
opt.relativenumber = false

-- Indentation
opt.shiftwidth = 2
opt.tabstop = 2
opt.expandtab = true

-- Scrolling
opt.scrolloff = 4
opt.sidescrolloff = 8

-- Wrap long lines
opt.wrap = true

-- Use ripgrep for :grep
opt.grepprg = "rg --vimgrep"
opt.grepformat = "%f:%l:%c:%m"

-- Treesitter folding (start unfolded)
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99
opt.foldlevelstart = 99

-- UI
opt.conceallevel = 2
opt.smoothscroll = true
opt.fillchars = {
  foldopen = "▼",
  foldclose = "▶",
  fold = " ",
  foldsep = " ",
  diff = "/",
  eob = " ",
}

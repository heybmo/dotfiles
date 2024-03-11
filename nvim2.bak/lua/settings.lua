
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.o.encoding = "utf-8"
vim.o.backspace = "indent,eol,start" -- backspace works on every char in insert mode
vim.g.completeopt = "menu,menuone,noselect,noinsert,longest,preview"
vim.o.history = 1000
vim.o.dictionary = "/usr/share/dict/words"
vim.o.startofline = true
vim.o.clipboard = "unnamedplus"
vim.o.autoread = true
vim.o.foldenable = true
vim.o.foldmethod = "manual"
-- Confirm to save changes before exiting modified buffer.
vim.o.confirm = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.textwidth = 79
vim.o.number = true
-- Mapping waiting time
vim.o.redrawtime = 1500
vim.o.timeoutlen = 300


local o = vim.opt
local g = vim.g

g.mapleader = " "
g.maplocalleader = " "
o.encoding = "utf-8"
o.backspace = "indent,eol,start" -- backspace works on every char in insert mode
g.completeopt = "menu,menuone,noselect,noinsert,longest,preview"
o.history = 1000
o.dictionary = "/usr/share/dict/words"
o.startofline = true
o.clipboard = "unnamedplus"
o.autoread = true
-- Confirm to save changes before exiting modified buffer.
o.confirm = true


-- Mapping waiting time
o.redrawtime = 1500
o.timeoutlen = 300

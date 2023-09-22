-- Vim-wide configs
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.o.encoding = "utf-8"
vim.o.scriptencoding = "utf-8"
vim.o.fileencoding = "utf-8"
vim.o.backup = false

-- Editing
vim.o.smartcase = true
vim.o.smarttab = true
vim.o.ai = true
vim.o.si = true
vim.o.backspace = "indent,eol,start" -- backspace works on every char in insert mode
vim.o.clipboard = "unnamedplus"
vim.o.autoread = true
-- Confirm to save changes before exiting modified buffer
vim.o.confirm = true
vim.o.expandtab = true -- expand tab to spaces
vim.o.undolevels = 1000

vim.o.title = true
vim.o.number = true
vim.opt.termguicolors = true
vim.o.mouse = "a"
vim.o.numberwidth = 4
vim.laststatus = 2
vim.o.wrap = false

-- Searching
vim.o.incsearch = true
vim.o.wildmenu = true
vim.o.wildignore = vim.o.wildignore .. "*/tmp/*,*.so,*.swp,*.zip,*~"



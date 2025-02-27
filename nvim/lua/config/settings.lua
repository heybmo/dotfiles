-- @module settings.lua
-- @description Global settings for nvim
--

local HOME = os.getenv("HOME")
local opt = vim.opt

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.autoformat = true

opt.autowrite = true
opt.clipboard = "unnamedplus"
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 2 -- Hide `*` markup
opt.confirm = true -- confirm to save changes before exiting buffer
opt.cursorline = true -- highlight current line
opt.expandtab = true -- spaces over tabs, spaces ftw
opt.fillchars = {
	foldopen = "▼",
	foldclose = "▶",
	fold = " ",
	foldsep = " ",
	diff = "/",
	eob = " ",
}

vim.bo.expandtab = true
vim.bo.smartindent = true
opt.foldlevelstart = 10
opt.foldnestmax = 10
opt.foldenable = true

if vim.fn.has("nvim-0.10") == 1 then
	opt.smoothscroll = true
	opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
	opt.foldtext = "v:lua.vim.treesitter.foldtext()"
	opt.foldmethod = "expr"
	opt.foldtext = ""
else
	opt.foldmethod = "indent"
	opt.foldtext = "v:lua.require'lazyvim.util'.ui.foldtext()"
end

opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true
opt.inccommand = "nosplit"
opt.laststatus = 3
opt.linebreak = true

opt.linebreak = true
opt.mouse = "a"

opt.number = true
opt.relativenumber = false
opt.ruler = false
opt.scrolloff = 4 -- Lines of context around
opt.shiftround = true
opt.shiftwidth = 2 -- indent size default
opt.signcolumn = "yes" -- Always show sign column
opt.smartcase = true
opt.smartindent = true
opt.spelllang = { "en" }

opt.sidescrolloff = 8
opt.termguicolors = true -- True color support
opt.timeoutlen = vim.g.vscode and 1000 or 300
opt.undofile = true
opt.undolevels = 1000
opt.updatetime = 200
opt.wrap = false -- Disable line wrapping

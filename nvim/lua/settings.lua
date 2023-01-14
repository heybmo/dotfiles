HOME = os.getenv("HOME")

-- basic setting
vim.g.mapleader = " "
vim.o.encoding = "utf-8"
vim.o.scriptencoding = "utf-8"
vim.o.backspace = "indent,eol,start" -- backspace works on every char in insert mode
vim.g.completeopt = 'menu,menuone,noselect,noinsert,longest,preview'
vim.o.history = 1000
vim.o.dictionary = '/usr/share/dict/words'
vim.o.startofline = true
vim.o.clipboard = 'unnamedplus'
vim.o.autoread = true
-- Confirm to save changes before exiting modified buffer
vim.o.confirm = true

-- Mapping waiting time
vim.o.redrawtime = 1500
vim.o.timeoutlen = 300
-- IMPORTANT: be careful about changing this value--
-- used to determine when to show diagnostics window
-- for LSP.
vim.o.updatetime = 200
vim.o.ttimeout = true

-- Display
vim.opt.termguicolors = true
vim.o.showmatch       = true -- show matching brackets
vim.o.scrolloff       = 3 -- always show 3 rows from edge of the screen
vim.o.synmaxcol       = 300 -- stop syntax highlight after x lines for performance
vim.o.laststatus      = 2 -- always show status line
vim.o.cursorline      = true
-- vim.o.lazyredraw      = true
vim.o.background      = 'dark'
vim.opt.termguicolors = true

vim.o.list = true -- do not display whitespace characters
-- vim.opt.listchars = {
--   eol = '⤶',
--   trail = '.',
-- }

vim.o.foldenable = true
vim.o.foldlevel = 5 -- limit folding to 5 levels
vim.o.foldmethod = 'expr' -- use language syntax to generate folds
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.wrap = false --do not wrap lines even if very long
vim.o.eol = false -- show if there's no eol char
vim.o.showbreak = '↪' -- character to show when line is broken
vim.o.mouse = 'a';

-- Sidebar
vim.o.number = true -- line number on the left
vim.o.numberwidth = 3 -- always reserve 3 spaces for line number
vim.o.signcolumn = 'yes' -- keep 1 column for coc.vim  check
vim.o.modelines = 1
vim.o.showcmd = true -- display command in bottom bar

-- Search
vim.o.grepprg = 'rg --vimgrep'
vim.o.incsearch = true -- starts searching as soon as typing, without enter needed
vim.o.ignorecase = true -- ignore letter case when searching
vim.o.smartcase = true -- case insentive unless capitals used in search
vim.o.wildmenu = true
vim.o.wildignore = vim.o.wildignore .. "*/tmp/*,*.so,*.swp,*.zip,*~"
-- vim.o.matchtime = 1 -- delay before showing matching paren

-- White characters
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.tabstop = 2 -- 1 tab = 2 spaces
vim.o.shiftwidth = 2 -- indentation rule
vim.o.formatoptions = 'qnj1' -- q  - comment formatting; n - numbered lists; j - remove comment when joining lines; 1 - don't break after one-letter word
vim.o.expandtab = true -- expand tab to spaces

-- Backup files
vim.o.backup = true -- use backup files
vim.o.writebackup = false
vim.o.swapfile = false -- do not use swap file
vim.o.undofile = true
vim.o.undolevels = 10000
vim.o.undodir = HOME .. '/.vim/tmp/undo//' -- undo files
vim.o.backupdir = HOME .. '/.vim/tmp/backup//' -- backups
vim.o.directory = '/.vim/tmp/swap//' -- swap files

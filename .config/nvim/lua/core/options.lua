-- General settings
vim.o.mouse = "a"
vim.g.mapleader = " "
vim.o.number = true
vim.o.cursorline = true
vim.o.signcolumn = "yes"
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
vim.o.showmode = false
vim.o.clipboard = "unnamedplus"
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.termguicolors = true
vim.o.updatetime = 100
vim.o.wrap = false
vim.o.confirm = true
vim.o.hlsearch = true
vim.opt.shortmess:append("W")

-- Indentation settings
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.o.copyindent = true
vim.o.preserveindent = true
vim.o.shiftround = true

-- Undo settings
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.undodir"

-- Language providers
vim.g.python3_host_prog = vim.fn.expand("~/.pyenv/versions/nvim/bin/python")
vim.g.loaded_perl_provider = 0

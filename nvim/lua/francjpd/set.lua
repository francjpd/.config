-- numbering
vim.opt.nu = true
vim.opt.relativenumber = true

--  vim indentation
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.wrap = true

-- Vim backups disabled as we have undotree
vim.opt.swapfile = false
vim.opt.backup = false
-- not working on windows for now vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- search
vim.opt.hlsearch = false
vim.opt.incsearch = true

--
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50
vim.opt.conceallevel = 2

vim.g.mapleader = " "

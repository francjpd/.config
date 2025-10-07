require("francjpd.remap")
require("francjpd.set")
require("francjpd.lazy_init")

local augroup = vim.api.nvim_create_augroup
local francjpdGroup = augroup("francjpd", {})
local autocmd = vim.api.nvim_create_autocmd
autocmd({ "BufWritePre" }, { group = francjpdGroup, pattern = "*", command = [[%s/\s\+$//e]] })

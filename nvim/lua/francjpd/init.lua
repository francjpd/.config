require("francjpd.remap")
require("francjpd.set")
require("francjpd.lazy_init")
local formatter = require("francjpd.python.formatter")
formatter.setup()
local render_header = require("francjpd.python.render_header")
render_header.setup()

local notebook_render = require("francjpd.python.notebook_render")
notebook_render.setup()

local augroup = vim.api.nvim_create_augroup
local francjpdGroup = augroup("francjpd", {})
local autocmd = vim.api.nvim_create_autocmd
autocmd({ "BufWritePre" }, { group = francjpdGroup, pattern = "*", command = [[%s/\s\+$//e]] })

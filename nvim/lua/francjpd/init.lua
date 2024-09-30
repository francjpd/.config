require("francjpd.remap")
require("francjpd.set")
require("francjpd.lazy_init")

local augroup = vim.api.nvim_create_augroup
local francjpdGroup = augroup("francjpd", {})
local autocmd = vim.api.nvim_create_autocmd
autocmd({ "BufWritePre" }, { group = francjpdGroup, pattern = "*", command = [[%s/\s\+$//e]] })

autocmd("LspAttach", {
	group = francjpdGroup,
	callback = function(e)
		local opts = { buffer = e.buf }

		vim.keymap.set("n", "gd", function()
			vim.lsp.buf.definition()
		end, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover()
		end, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))
		vim.keymap.set("n", "<leader>vws", function()
			vim.lsp.buf.workspace_symbol()
		end, vim.tbl_extend("force", opts, { desc = "Search workspace symbols" }))
		vim.keymap.set("n", "<leader>vd", function()
			vim.diagnostic.open_float()
		end, vim.tbl_extend("force", opts, { desc = "Open diagnostic float" }))
		vim.keymap.set("n", "<leader>vca", function()
			vim.lsp.buf.code_action()
		end, vim.tbl_extend("force", opts, { desc = "Code action" }))
		vim.keymap.set("n", "<leader>vrr", function()
			vim.lsp.buf.references()
		end, vim.tbl_extend("force", opts, { desc = "Find references" }))
		vim.keymap.set("n", "<leader>vrn", function()
			vim.lsp.buf.rename()
		end, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
		vim.keymap.set("i", "<C-h>", function()
			vim.lsp.buf.signature_help()
		end, vim.tbl_extend("force", opts, { desc = "Signature help" }))
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.goto_next()
		end, vim.tbl_extend("force", opts, { desc = "Go to next diagnostic" }))
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.goto_prev()
		end, vim.tbl_extend("force", opts, { desc = "Go to previous diagnostic" }))
	end,
})

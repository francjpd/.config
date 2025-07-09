return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
	},

	config = function()
		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)

		local on_attach = function(client, bufnr)
			local opts = { buffer = bufnr, remap = false }
			-- Code actions (this is what you want!)
			vim.keymap.set(
				"n",
				"<leader>ca",
				vim.lsp.buf.code_action,
				vim.tbl_extend("force", opts, { desc = "LSP: Code Actions (imports, fixes, etc.)" })
			)

			-- Navigation
			vim.keymap.set(
				"n",
				"gd",
				vim.lsp.buf.definition,
				vim.tbl_extend("force", opts, { desc = "LSP: Go to Definition" })
			)
			vim.keymap.set(
				"n",
				"<leader>vrr",
				vim.lsp.buf.references,
				vim.tbl_extend("force", opts, { desc = "LSP: Show References" })
			)

			-- Documentation
			vim.keymap.set(
				"n",
				"K",
				vim.lsp.buf.hover,
				vim.tbl_extend("force", opts, { desc = "LSP: Hover Documentation" })
			)
			vim.keymap.set(
				"i",
				"<C-h>",
				vim.lsp.buf.signature_help,
				vim.tbl_extend("force", opts, { desc = "LSP: Signature Help" })
			)

			-- Workspace
			vim.keymap.set(
				"n",
				"<leader>vws",
				vim.lsp.buf.workspace_symbol,
				vim.tbl_extend("force", opts, { desc = "LSP: Workspace Symbols" })
			)

			-- Refactoring
			vim.keymap.set(
				"n",
				"<leader>vrn",
				vim.lsp.buf.rename,
				vim.tbl_extend("force", opts, { desc = "LSP: Rename Symbol" })
			)

			-- Diagnostics
			vim.keymap.set(
				"n",
				"<leader>vd",
				vim.diagnostic.open_float,
				vim.tbl_extend("force", opts, { desc = "LSP: Show Diagnostic" })
			)
			vim.keymap.set(
				"n",
				"[d",
				vim.diagnostic.goto_prev,
				vim.tbl_extend("force", opts, { desc = "LSP: Previous Diagnostic" })
			)
			vim.keymap.set(
				"n",
				"]d",
				vim.diagnostic.goto_next,
				vim.tbl_extend("force", opts, { desc = "LSP: Next Diagnostic" })
			)
		end

		require("fidget").setup({})
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"rust_analyzer",
			},
			handlers = {
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
						on_attach = on_attach,
					})
				end,

				["lua_ls"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						on_attach = on_attach,
						settings = {
							Lua = {
								runtime = { version = "Lua 5.1" },
								diagnostics = {
									globals = { "vim", "it", "describe", "before_each", "after_each" },
								},
							},
						},
					})
				end,
			},
		})

		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- For luasnip users.
			}, {
				{ name = "buffer" },
			}),
		})

		vim.diagnostic.config({
			update_in_insert = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})
	end,
}

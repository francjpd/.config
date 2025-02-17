return {
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-telescope/telescope.nvim",
			{ "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } },
		},

		keys = { -- Example mapping to toggle outline
			{
				"<leader>c",
				function()
					CodeCompanionChat()
				end,
				desc = "Code Companion chat",
			},
		},
		config = function()
			require("codecompanion").setup({
				opts = {
					log_level = "DEBUG",
				},
				adapters = {
					codellama = function()
						return require("codecompanion.adapters").extend("ollama", {
							schema = {
								model = {
									default = "llama3.2",
								},
							},
						})
					end,
				},
				strategies = {
					chat = { adapter = "codellama" },
					inline = { adapter = "codellama" },
					agent = { adapter = "codellama" },
				},
			})
		end,
	},
	{
		"saghen/blink.cmp",
		dependencies = "rafamadriz/friendly-snippets",
		version = "*",
		opts = {
			keymap = { preset = "default" },
			sources = {
				default = { "lsp", "path", "buffer", "snippets", "codecompanion" },
				providers = {
					codecompanion = {
						name = "CodeCompanion",
						module = "codecompanion.providers.completion.blink",
					},
				},
			},
		},
	},
}

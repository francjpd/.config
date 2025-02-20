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
					vim.cmd("CodeCompanionChat Toggle")
				end,
				desc = "Code Companion chat",
			},
			{
				"<leader>cp",
				function()
					vim.cmd("CodeCompanionActions")
				end,
				desc = "Code companion actions",
			},
		},
		config = function()
			require("codecompanion").setup({
				opts = {
					log_level = "DEBUG",
				},
				adapters = {
					openai = function()
						return require("codecompanion.adapters").extend("openai", {
							env = {
								api_key = "",
							},
						})
					end,
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
					chat = { adapter = "openai" },
					inline = { adapter = "openai" },
					agent = { adapter = "openai" },
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

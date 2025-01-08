return {
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-telescope/telescope.nvim",
			{ "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } },
		},
		config = function()
			require("codecompanion").setup({
				adapters = {
					ollama = function()
						return require("codecompanion.adapters").extend("ollama", {
							env = {
								url = "http://localhost:11434",
							},
							parameters = {
								sync = true,
							},
							schema = {
								model = {
									default = "nezahatkorkmaz/deepseek-v3",
								},
							},
						})
					end,
				},
			})
		end,
	},
	{
		"saghen/blink.cmp",
		opts = {
			sources = {
				default = { "lsp", "path", "buffer", "codecompanion" },
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

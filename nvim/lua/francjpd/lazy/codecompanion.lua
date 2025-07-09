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
				adapters = {
					perplexity = function()
						return require("codecompanion.adapters").extend("openai_compatible", {
							env = {
								url = "https://api.perplexity.ai",
								api_key = vim.env.PERPLEXITY_API_KEY,
								chat_url = "/chat/completions",
								models_endpoint = "/models",
							},
							schema = {
								model = {
									default = "sonar-pro",
								},
								temperature = {
									order = 2,
									mapping = "parameters",
									type = "number",
									optional = true,
									default = 0.7,
									desc = "Controls randomness in responses",
									validate = function(n)
										return n >= 0 and n <= 2, "Must be between 0 and 2"
									end,
								},
								max_tokens = {
									order = 3,
									mapping = "parameters",
									type = "integer",
									optional = true,
									default = 1000,
									desc = "Maximum number of tokens to generate",
									validate = function(n)
										return n > 0, "Must be greater than 0"
									end,
								},
							},
						})
					end,
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
					chat = { adapter = "perplexity" },
					inline = { adapter = "perplexity" },
					agent = { adapter = "perplexity" },
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

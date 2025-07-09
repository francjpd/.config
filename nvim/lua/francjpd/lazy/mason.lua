return {
	{
		"williamboman/mason.nvim",
		version = "^1.8.0",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		version = "^1.24.0",
		dependencies = { "williamboman/mason.nvim" },
	},
}

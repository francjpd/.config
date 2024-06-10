return {
	"epwalsh/obsidian.nvim",
	ft = "markdown",
	event = {
	  -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
	  -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
	  "BufReadPre C:\\Users\\franc\\Documents\\francjpd\\**.md",
	  "BufNewFile C:\\Users\\franc\\Documents\\francjpd\\**.md",
	},
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",
	},
	opts = {
		workspaces = {
			{
				name = "francjpd",
				path = "C:\\Users\\franc\\Documents\\francjpd",
			},
		},
	},
}

return {
	{
		"echasnovski/mini.nvim",
		version = false,
		config = function()
			-- Setup for mini.pairs
			require("mini.pairs").setup()

			-- Setup for mini.surround with custom keybindings
			require("mini.surround").setup({
				mappings = {
					add = "gsa",
					delete = "gsd",
					find = "gsf",
					find_left = "gsF",
					highlight = "gsh",
					replace = "gsr",
					update_n_lines = "gsn",
				},
			})
		end,
	},
}

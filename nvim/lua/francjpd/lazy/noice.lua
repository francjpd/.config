return {
	"folke/noice.nvim",
	dependencies = {
		"Muniftanjim/nui.nvim",
	},
	opts = function(_, opts)
		-- Ensure opts.routes is initialized
		opts.routes = opts.routes or {}
		table.insert(opts.routes, {
			filter = {
				event = "notify",
				find = "No information available",
			},
			opts = { skip = true },
		})

		opts.presets = opts.presets or {}
		opts.presets.lsp_doc_border = true
		opts.presets.bottom_search = true
		opts.presets.command_palette = true
		opts.presets.long_message_to_split = true
	end,
}

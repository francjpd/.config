return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon").setup({
			menu = {
				width = 50,
				height = 8,
				borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
			},
		})
		require("telescope").load_extension("harpoon")

		-- REQUIRED
		harpoon:setup()
		-- REQUIRED

		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():add()
		end, { desc = "Add file to Harpoon list" })
		vim.keymap.set("n", "<C-e>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Toggle Harpoon quick menu" })

		vim.keymap.set("n", "<space>1", function()
			harpoon:list():select(1)
		end, { desc = "Select first file in Harpoon list" })
		vim.keymap.set("n", "<space>2", function()
			harpoon:list():select(2)
		end, { desc = "Select second file in Harpoon list" })
		vim.keymap.set("n", "<space>3", function()
			harpoon:list():select(3)
		end, { desc = "Select third file in Harpoon list" })
		vim.keymap.set("n", "<space>4", function()
			harpoon:list():select(4)
		end, { desc = "Select fourth file in Harpoon list" })

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<C-S-P>", function()
			harpoon:list():prev()
		end, { desc = "Select previous file in Harpoon list" })
		vim.keymap.set("n", "<C-S-N>", function()
			harpoon:list():next()
		end, { desc = "Select next file in Harpoon list" })
	end,
}

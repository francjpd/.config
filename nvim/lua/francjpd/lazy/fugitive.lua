return {
	"tpope/vim-fugitive",
	config = function()
		vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Open Git status" })

		local ThePrimeagen_Fugitive = vim.api.nvim_create_augroup("ThePrimeagen_Fugitive", {})

		local autocmd = vim.api.nvim_create_autocmd
		autocmd("BufWinEnter", {
			group = ThePrimeagen_Fugitive,
			pattern = "*",
			callback = function()
				if vim.bo.ft ~= "fugitive" then
					return
				end

				local bufnr = vim.api.nvim_get_current_buf()
				local opts = { buffer = bufnr, remap = false }
				vim.keymap.set("n", "<leader>p", function()
					vim.cmd.Git("push")
				end, opts, { desc = "Git push" })

				-- rebase always
				vim.keymap.set("n", "<leader>P", function()
					vim.cmd.Git({ "pull", "--rebase" })
				end, opts, { desc = "Git pull with rebase" })

				-- NOTE: It allows me to easily set the branch I am pushing and any tracking
				-- needed if I did not set the branch up correctly
				vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts, { desc = "Git push with upstream" })
			end,
		})

		vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>", { desc = "Get changes from left side" })
		vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>", { desc = "Get changes from right side" })
	end,
}

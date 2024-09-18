vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open the file explorer" })
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Replace selection with default register without overwriting it" })

-- moves selected lines to up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- 'n' and 'v' yank the selected text to the system clipboard.
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "yank text to System Clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "yank text to System Clipboard" })

-- Rapidly scroll down / up
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Next item in quickfix list" })
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Previous item in quickfix list" })
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Next item in location list" })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Previous item in location list" })

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Substitute word under cursor" })

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
-- moves selected lines to up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- 'n' and 'v' yank the selected text to the system clipboard.
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])


vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Define the fold expression for JavaScript, TypeScript, Vue, JSX, and TSX files
-- local foldexpr_js_ts = function()
--   vim.wo.foldmethod = 'expr'
--   vim.wo.foldexpr =
--   'getline(v:lnum)=~\'^\\s*/\\*\\*\'&&getline(v:lnum+1)=~\'\\*/\'?1:getline(v:lnum-1)=~\'^\\s*/\\*\\*\'?0:getline(v:lnum)=~\'\\*/\'?-1:1'
-- end
--
-- -- Keymap to enable folding with the defined fold expression
-- vim.api.nvim_set_keymap('n', '<leader>fc', '', { noremap = true, silent = true, callback = foldexpr_js_ts })
--
-- -- Autocommand to apply the fold expression only for specific file types
-- vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
--   pattern = { '*.js', '*.ts', '*.vue', '*.jsx', '*.tsx' },
--   callback = function()
--     vim.api.nvim_buf_set_keymap(0, 'n', '<leader>fc', '', { noremap = true, silent = true, callback = foldexpr_js_ts })
--   end
-- })

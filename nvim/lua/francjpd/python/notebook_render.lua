local M = {}

-- Namespace for highlights / virtual text
local ns = vim.api.nvim_create_namespace("notebook_render")

-- 🌈 Highlight groups
vim.api.nvim_set_hl(0, "NotebookCellMarker", { fg = "#ff79c6", bold = true })
vim.api.nvim_set_hl(0, "NotebookHeader1", { fg = "#ff79c6", bold = true })
vim.api.nvim_set_hl(0, "NotebookHeader2", { fg = "#ffb86c", bold = true })
vim.api.nvim_set_hl(0, "NotebookHeader3", { fg = "#8be9fd", bold = true })

-- Determine header level
local function header_level(line)
	if line:match("^###") then
		return 3
	elseif line:match("^##") then
		return 2
	elseif line:match("^#") then
		return 1
	else
		return 0
	end
end

-- Generate formatted text for headers
local function format_header(line, level)
	local text = line:gsub("^#+%s*", "")
	if level == 1 then
		return "## " .. text .. " ##"
	elseif level == 2 then
		return "### " .. text .. " ###"
	elseif level == 3 then
		return "#### " .. text .. " ####"
	end
	return text
end

-- Render notebook content into buffer
function M.render_notebook(buf, json_content)
	if not vim.api.nvim_buf_is_valid(buf) then
		return
	end
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, {})
	vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)

	-- Decode JSON safely
	local ok, notebook = pcall(vim.fn.json_decode, json_content)
	if not ok or type(notebook) ~= "table" or not notebook.cells then
		return
	end

	local out_lines = {}

	for _, cell in ipairs(notebook.cells) do
		if cell.cell_type == "code" then
			table.insert(out_lines, "#%% Code cell")
			for _, line in ipairs(cell.source or {}) do
				table.insert(out_lines, tostring(line):gsub("\n$", ""))
			end
			table.insert(out_lines, "") -- Add spacing after each cell
		elseif cell.cell_type == "markdown" then
			for _, line in ipairs(cell.source or {}) do
				local clean = tostring(line):gsub("\n$", "")
				local lvl = header_level(clean)
				local formatted = format_header(clean, lvl)
				table.insert(out_lines, formatted)
			end
			table.insert(out_lines, "")
		end
	end

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, out_lines)
	vim.bo[buf].filetype = "python"
end

-- Save back to JSON
function M.save_notebook(buf, filepath)
	local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
	local notebook = { cells = {} }

	local current_cell = nil
	for _, line in ipairs(lines) do
		if line:match("^#%%") then
			if current_cell then
				table.insert(notebook.cells, current_cell)
			end
			current_cell = { cell_type = "code", source = {} }
		else
			if current_cell then
				table.insert(current_cell.source, line .. "\n")
			end
		end
	end

	if current_cell then
		table.insert(notebook.cells, current_cell)
	end

	local json = vim.fn.json_encode(notebook)
	vim.fn.writefile(vim.split(json, "\n"), filepath)
end

-- Setup autocommands
function M.setup()
	vim.api.nvim_create_autocmd("BufReadPost", {
		pattern = "*.ipynb",
		callback = function(args)
			local content = table.concat(vim.fn.readfile(args.file), "\n")
			M.render_notebook(args.buf, content)
			vim.bo[args.buf].modifiable = true
		end,
	})

	vim.api.nvim_create_autocmd("BufWritePost", {
		pattern = "*.ipynb",
		callback = function(args)
			M.save_notebook(args.buf, args.file)
		end,
	})
end

return M

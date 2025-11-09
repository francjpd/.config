local M = {}

local ns = vim.api.nvim_create_namespace("big_headers")

local function header_level(line)
	if line:match("^####") then
		return 3
	elseif line:match("^###") then
		return 2
	elseif line:match("^##") then
		return 1
	else
		return nil
	end
end

local function get_hl(level)
	if level == 1 then
		return "HeaderH1"
	elseif level == 2 then
		return "HeaderH2"
	elseif level == 3 then
		return "HeaderH3"
	end
end

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

function M.render_headers(buf)
	if not vim.api.nvim_buf_is_valid(buf) then
		return
	end
	vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)

	local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
	local cursor_row = vim.api.nvim_win_get_cursor(0)[1] - 1

	for i, line in ipairs(lines) do
		local level = header_level(line)
		if level then
			local text = format_header(line, level)
			local hl = get_hl(level)
			if i - 1 ~= cursor_row then
				vim.api.nvim_buf_set_extmark(buf, ns, i - 1, 0, {
					virt_text = { { text, hl } },
					virt_text_pos = "overlay", -- shows on top of line
					hl_mode = "combine",
				})
			end
		end
	end
end

function M.setup()
	-- Grayish highlights
	vim.cmd("highlight default HeaderH1 guifg=#999999 gui=bold,italic")
	vim.cmd("highlight default HeaderH2 guifg=#888888 gui=bold")
	vim.cmd("highlight default HeaderH3 guifg=#777777 gui=italic")

	vim.api.nvim_create_autocmd({ "BufEnter", "TextChanged", "TextChangedI", "CursorMoved", "WinScrolled" }, {
		pattern = "*.py",
		callback = function(args)
			M.render_headers(args.buf)
		end,
	})
end

return M

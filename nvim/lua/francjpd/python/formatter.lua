-- python/formatter.lua

local M = {}

-- 🧩 Namespace for the cell marker highlights
local ns = vim.api.nvim_create_namespace("cell_markers")

-- 🎨 Highlight for the comment itself
vim.api.nvim_set_hl(0, "CellMarker", { fg = "#ff79c6", bold = true })
vim.api.nvim_set_hl(0, "CellMarkerIcon", { fg = "#ff79c6", bold = true })
vim.api.nvim_set_hl(0, "CellHeader1", { fg = "#ff79c6", bold = true }) -- ### -> biggest
vim.api.nvim_set_hl(0, "CellHeader2", { fg = "#ffb86c", bold = true }) -- ## -> medium
vim.api.nvim_set_hl(0, "CellHeader3", { fg = "#8be9fd", bold = true }) -- # -> normal comment

-- 🪄 Function to paint #%% lines + icon
function M.paint_cell_markers(buf)
	if not vim.api.nvim_buf_is_valid(buf) then
		return
	end
	vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)

	local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
	for i, line in ipairs(lines) do
		if line:match("^#%%") then
			vim.api.nvim_buf_add_highlight(buf, ns, "CellMarker", i - 1, 0, -1)
			vim.api.nvim_buf_set_extmark(buf, ns, i - 1, 0, {
				virt_text = { { "🧩", "CellMarkerIcon" } },
				virt_text_pos = "right_align",
			})
		end
	end
end

-- ⚡ Setup autocommands
function M.setup()
	local debounce_timer = vim.loop.new_timer()
	local function schedule_paint(buf)
		debounce_timer:stop()
		debounce_timer:start(
			100,
			0,
			vim.schedule_wrap(function()
				M.paint_cell_markers(buf)
			end)
		)
	end

	vim.api.nvim_create_autocmd({ "BufEnter", "TextChanged", "TextChangedI" }, {
		pattern = "*.py",
		callback = function(args)
			schedule_paint(args.buf)
		end,
	})
end

return M

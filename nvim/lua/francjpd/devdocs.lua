local function hover_and_devdocs()
	local word

	word = vim.fn.expand("<cword>")

	-- 2️⃣ Open DevDocs in browser if word exists
	if word and word ~= "" then
		local url = "https://devdocs.io/#q=" .. vim.fn.escape(word, "#%")
		vim.fn.jobstart({ "xdg-open", url }, { detach = true })
	end
end

return hover_and_devdocs

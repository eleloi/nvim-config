vim.pack.add({
	"https://github.com/b0o/incline.nvim",
})

local helpers = require("incline.helpers")
require("incline").setup({

	window = {
		margin = { horizontal = 0, vertical = 0 },
		padding = 0,
	},
	render = function(props)
		-- Only show if window is not focused
		if props.focused then
			return ""
		end

		local full_path = vim.api.nvim_buf_get_name(props.buf)
		local filename = vim.fn.fnamemodify(full_path, ":t")
		-- Get relative path for display
		local relative_path = vim.fn.fnamemodify(full_path, ":.")

		if filename == "" then
			return { { "[No Name]", gui = "italic" } }
		end

		local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
		local modified = vim.bo[props.buf].modified and " ●" or ""

		-- Differentiate directory and filename colors
		local dirname = vim.fn.fnamemodify(relative_path, ":h")
		if dirname == "." then
			dirname = ""
		else
			dirname = dirname .. "/"
		end

		return {
			{ (ft_icon or "") .. " ", guifg = ft_color },
			{ dirname, guifg = "#808080" },
			{ filename, gui = "bold" },
			{ modified, guifg = "#e67e80" },
			{ " ", guibg = "none" },
		}
	end,
})

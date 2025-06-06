-- Manages color schemes
return {
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("kanagawa").setup({
				theme = "dragon",
				overrides = function(colors)
					return {
						["@markup.strong.markdown"] = { fg = colors.palette.sakuraPink, bold = true },
						["@markup.strong.markdown_inline"] = { fg = colors.palette.sakuraPink, bold = true },
						["@markup.italic.markdown"] = { fg = colors.palette.springGreen, italic = true },
						["@markup.italic.markdown_inline"] = { fg = colors.palette.springGreen, italic = true },
					}
				end,
			})
			vim.cmd("colorscheme kanagawa-dragon")
		end,
	},
}

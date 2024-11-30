-- View colors in certain files
return {
	"norcalli/nvim-colorizer.lua",
	event = "VeryLazy",
	config = function()
		require("colorizer").setup({
			"css",
			"javascript",
			"typesciprt",
			"javascriptreact",
			"typescriptreact",
			"html",
			"lua",
			"python",
			"json",
			"conf",
		})
	end,
}

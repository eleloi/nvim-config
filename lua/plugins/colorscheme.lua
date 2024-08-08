return {
	{
		"vague2k/huez.nvim",
		dependencies = {
			"sainnhe/gruvbox-material",
			"0xstepit/flow.nvim",
		},
		import = "huez-manager.import",
		lazy = false,
		priority = 1000,
		keys = {
			{ "<leader>fcc", "<CMD>Huez<CR>", desc = "Huez Manager" },
			{ "<leader>fcl", "<CMD>HuezLive<CR>", desc = "Huez Live" },
			{ "<leader>fcf", "<CMD>HuezFavorites<CR>", desc = "Huez Favorites" },
		},
		config = function()
			require("huez").setup({
				fallback = "gruvbox-material",
			})
		end,
	},
}

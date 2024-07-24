return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	config = true,
	keys = {
		{
			"<leader>ft",
			"<CMD>Trouble<CR>",
			desc = "Trouble",
			mode = "n",
		},
	},
}

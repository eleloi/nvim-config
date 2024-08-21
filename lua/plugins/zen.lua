return {
	{
		"folke/zen-mode.nvim",
		keys = { { "<leader>zz", "<cmd>ZenMode<cr>", desc = "Zen mode" } },
	},
	{
		"shortcuts/no-neck-pain.nvim",
		version = "*",
		keys = { { "<leader>zZ", "<cmd>NoNeckPain<cr>", desc = "Zen mode" } },
		config = function()
			require("no-neck-pain").setup({
				buffers = {
					scratchPad = {
						enabled = true,
						location = "~/Documents/scratchpad",
					},
					bo = {
						filetype = "md",
					},
				},
			})
		end,
	},
}

return {
	"shortcuts/no-neck-pain.nvim",
	version = "*",
	keys = { { "<leader>zz", "<cmd>NoNeckPain<cr>", desc = "Zen mode" } },
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
}

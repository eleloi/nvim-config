return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		bigfile = {
			enabled = true,
			size = 10 * 1024 * 1024, -- 10 MB
		},
		bufdelete = { enabled = true },
		quickfile = { enabled = true },
		indent = {
			enabled = true,
			indent = {
				only_scope = true,
				only_current = true,
			},
		},
		input = { enabled = false },
		notifier = { enabled = false },
		scroll = { enabled = false },
		statuscolumn = { enabled = false },
		words = { enabled = false },
	},
	keys = {
		{
			"<leader>bd",
			function()
				Snacks.bufdelete()
			end,
			desc = "Delete current buffer",
		},
		{
			"<leader>bD",
			function()
				Snacks.bufdelete.other()
			end,
			desc = "Delete all buffers except current",
		},
	},
}

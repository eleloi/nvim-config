return {
	{
		keys = {
			{ "<leader>gd", ":DiffviewOpen<cr>", desc = "Diffview" },
		},
		"sindrets/diffview.nvim",
	},
	{
		"tpope/vim-fugitive",
		cmd = { "G", "Git" },
		event = "VeryLazy",
		keys = {
			{ "<leader>gg", ":tab Git<CR>", desc = "Git" },
		},
		config = function()
			vim.api.nvim_create_autocmd("BufReadPost", {
				callback = function()
					vim.g.bufhidden = "delete"
				end,
			})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signcolumn = false,
			numhl = true,
			max_file_length = 10000,
		},
	},
	{
		"junegunn/gv.vim",
		dependencies = {
			"tpope/vim-fugitive",
		},
		cmd = { "GV" },
	},
	{
		"rbong/vim-flog",
		lazy = true,
		cmd = { "Flog", "Flogsplit", "Floggit" },
		dependencies = {
			"tpope/vim-fugitive",
		},
		keys = {
			{ "<leader>gl", ":Flog<CR>", desc = "Flog" },
		},
	},
}

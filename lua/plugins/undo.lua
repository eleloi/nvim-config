-- Undo tree viewer

return {
	{
		"mbbill/undotree",
		keys = {
			{ "<leader>fu", "<cmd>UndotreeToggle<cr>", desc = "Toggle undotree" },
		},
	},
	{
		"tzachar/highlight-undo.nvim",
		event = "VeryLazy",
		config = true,
	},
}

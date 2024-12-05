-- Funny things, <leader>x...

return {
	{
		"tamton-aquib/duck.nvim",
		config = true,
		keys = {
			{
				"<leader>xx",
				function()
					require("duck").hatch()
				end,
				desc = "Duck it!",
			},
			{
				"<leader>xX",
				function()
					require("duck").cook()
				end,
				desc = "Cook it!",
			},
		},
	},
	{
		"eandrju/cellular-automaton.nvim",
		keys = {
			{
				"<leader>xd",
				"<cmd>CellularAutomaton make_it_rain<cr>",
				desc = "Make it rain!",
			},
			{
				"<leader>xl",
				"<cmd>CellularAutomaton game_of_life<cr>",
				desc = "Game of life!",
			},
		},
	},
	{
		"marcussimonsen/let-it-snow.nvim",
		cmd = "LetItSnow", -- Wait with loading until command is run
		keys = {
			{
				"<leader>xs",
				"<cmd>LetItSnow<cr>",
				desc = "Let it snow!",
			},
		},
		opts = {},
	},
}

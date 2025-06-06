return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			local wk = require("which-key")
			wk.setup({
				delay = 1000,
			})
			wk.add({
				{ "<leader>R", desc = "Reload configuration" },
				{ "<leader>a", desc = "+ai" },
				{ "<leader>b", desc = "+buffer" },
				{ "<leader>c", group = "code" },
				{ "<leader>cD", desc = "Type Definition" },
				{ "<leader>ca", desc = "Code Action" },
				{ "<leader>cr", desc = "Rename" },
				{ "<leader>f", group = "find" },
				{ "<leader>fc", desc = "Colorschemes" },
				{ "<leader>g", desc = "+git" },
				{ "<leader>h", group = "hardtime/http rest" },
				{ "<leader>hc", desc = "🧠 Codeium" },
				{ "<leader>hl", desc = "Run last http request" },
				{ "<leader>hn", desc = "Run near http request" },
				{ "<leader>s", desc = "+harpoon" },
				{ "<leader>w", desc = "+save" },
				{ "<leader>x", desc = "+funny" },
				{ "g", group = "goto" },
				{ "gD", desc = "Goto Definition vsplit" },
				{ "gd", desc = "Goto Definition" },
				{ "gi", desc = "Goto Implementation" },
				{ "gr", desc = "Goto References" },
				{ "gw", desc = "Wrap lines" },
			})
			wk.setup()
		end,
	},
	{ "meznaric/key-analyzer.nvim", opts = {} },
}

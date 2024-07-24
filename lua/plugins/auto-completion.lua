return {
	{
		"hrsh7th/nvim-cmp",
		version = false,
		event = "VeryLazy",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-calc",
			"hrsh7th/cmp-git",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"KadoBOT/cmp-plugins",
			"hrsh7th/cmp-cmdline",
			"FelipeLema/cmp-async-path",
			"davidsierradz/cmp-conventionalcommits",
			"hrsh7th/cmp-emoji",
			{ "L3MON4D3/LuaSnip", version = "v1.*" },
			{
				"roobert/tailwindcss-colorizer-cmp.nvim",
				config = true,
			},
		},
		config = function()
			require("config.cmp")
		end,
	},

	{
		"L3MON4D3/LuaSnip",
		build = (not jit.os:find("Windows"))
				and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
			or nil,
		opts = {
			history = true,
			delete_check_events = "TextChanged",
		},
		keys = {
			{
				"<tab>",
				function()
					return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
				end,
				expr = true,
				silent = true,
				mode = "i",
			},
			{
				"<tab>",
				function()
					require("luasnip").jump(1)
				end,
				mode = "s",
			},
			{
				"<s-tab>",
				function()
					require("luasnip").jump(-1)
				end,
				mode = { "i", "s" },
			},
		},
	},
}

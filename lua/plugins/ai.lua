return {

	-- **Exafunction/codeium.vim:** - This plugin enables Codeium, a code and
	-- snippet completion tool, in Neovim. It has key mappings for
	-- enabling/disabling Codeium, accepting completions, cycling through
	-- completions, and clearing Codeium.
	--
	-- **piersolenski/wtf.nvim:** - This plugin integrates AI diagnostics and
	-- Google searches within Neovim. It offers commands for debugging diagnostics
	-- with AI and searching diagnostics with Google.

	{
		"Exafunction/codeium.vim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		event = "BufEnter",
		config = function()
			vim.g.codeium_enabled = true
		end,
		keys = {
			{
				"<leader>hce",
				function()
					vim.g.codeium_enabled = true
					vim.notify("Codeium: " .. (vim.g.codeium_enabled and "on" or "off"))
					vim.fn["CodeiumEnable"]()
				end,
				desc = "Enable Codeium",
			},
			{
				"<leader>hcd",
				function()
					vim.g.codeium_enabled = false
					vim.notify("Codeium: " .. (vim.g.codeium_enabled and "on" or "off"))
					vim.fn["CodeiumDisable"]()
				end,
				desc = "Disable Codeium",
			},
			{
				"<M-l>",
				function()
					return vim.fn["codeium#Accept"]()
				end,
				expr = true,
				desc = "Accpet codeium",
				mode = { "i" },
			},
			{
				"<M-j>",
				function()
					return vim.fn["codeium#CycleCompletions"](1)
				end,
				expr = true,
				desc = "Cycle completions fwd",
				mode = { "i" },
			},
			{
				"<M-k>",
				function()
					return vim.fn["codeium#CycleCompletions"](-1)
				end,
				expr = true,
				desc = "Cycle completions bwd",
				mode = { "i" },
			},
			{
				"<M-e>",
				function()
					return vim.fn["codeium#Clear"]()
				end,
				expr = true,
				desc = "Clear codeium",
				mode = { "i" },
			},
		},
	},
	{
		"piersolenski/wtf.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		opts = {},
		keys = {
			{
				"<leader>aw",
				mode = { "n", "x" },
				function()
					require("wtf").ai()
				end,
				desc = "Debug diagnostic with AI",
			},
			{
				mode = { "n" },
				"<leader>aW",
				function()
					require("wtf").search()
				end,
				desc = "Search diagnostic with Google",
			},
		},
	},
	{
		"madox2/vim-ai",
		cmd = {
			"AI",
			"AIChat",
			"AIEdit",
			"AIRedo",
			"AINewChat",
		},
	},
}

-- Codeium: Provides AI-powered code completions and suggestions.
-- WTF.nvim: Uses AI to debug diagnostics and search for solutions.
-- Avante.nvim: Offers AI-driven code conflict resolution and suggestions.

return {

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
		"yetone/avante.nvim",
		event = "VeryLazy",
		lazy = false,
		version = false, -- set this to "*" if you want to always pull the latest change, false to update on release
		opts = {
			---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
			provider = "claude",
			mappings = {
				--- @class AvanteConflictMappings
				diff = {
					ours = "co",
					theirs = "ct",
					all_theirs = "ca",
					both = "cb",
					cursor = "cc",
					next = "]x",
					prev = "[x",
				},
				suggestion = {
					accept = "<M-l>",
					next = "<M-]>",
					prev = "<M-[>",
					dismiss = "<C-]>",
				},
				jump = {
					next = "]]",
					prev = "[[",
				},
				submit = {
					normal = "<CR>",
					insert = "<C-s>",
				},
				sidebar = {
					apply_all = "A",
					apply_cursor = "a",
					switch_windows = "<Tab>",
					reverse_switch_windows = "<S-Tab>",
				},
			},
		},
		build = "make",
		dependencies = {
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = true,
					},
				},
			},
		},
	},
}

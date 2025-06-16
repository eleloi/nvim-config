return {
	{
		"vimwiki/vimwiki",
		-- event = "BufEnter *.md",
		event = "VeryLazy",
		keys = {
			{
				"<leader>ww",
				"<CMD>VimwikiIndex<CR>",
				desc = "Vimwiki Index",
			},
			{
				"<leader>wb",
				"<CMD>VimwikiBacklinks<CR>",
				desc = "BackLinks",
			},
		},
		-- The configuration for the plugin
		init = function()
			vim.g.vimwiki_global_ext = 0
			vim.g.vimwiki_list = {
				{
					path = "~/Documents/vimwiki/",
					syntax = "markdown",
					ext = "md",
					auto_diary_index = 1,
				},
			}
		end,
	},
	{
		"qadzek/link.vim",
		init = function()
			vim.g.link_use_default_mappings = false
		end,
		keys = {
			{
				"<leader>wl",
				"<CMD>LinkConvertAll<CR>",
				desc = "Add plugin config or keymap for Vimwiki links",
			},
		},
	},
}

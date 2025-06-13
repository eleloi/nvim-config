return {
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				"lazy.nvim",
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
			{ "moyiz/blink-emoji.nvim" },
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		init = function()
			-- Your DBUI configuration
			vim.g.db_ui_use_nerd_fonts = 1
		end,
	},
	{
		"xzbdmw/colorful-menu.nvim",
		config = true,
	},
	{
		"saghen/blink.cmp",

		dependencies = {
			"mikavilpas/blink-ripgrep.nvim",
			"rafamadriz/friendly-snippets",
		},

		version = "*",

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = {
				preset = "none",
				["<C-n>"] = { "show", "select_next", "fallback" },
				["<C-p>"] = { "select_prev", "fallback_to_mappings" },
				["<C-j>"] = { "show", "select_next", "fallback" },
				["<C-k>"] = { "select_prev", "fallback_to_mappings" },
				["<Tab>"] = { "select_and_accept", "fallback" },

				["<C-e>"] = { "hide" },
				["<Esc>"] = { "cancel", "fallback" },

				["<Up>"] = { "select_prev", "fallback" },
				["<Down>"] = { "select_next", "fallback" },

				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },
			},

			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},

			signature = { enabled = true },
			sources = {
				default = {
					"lsp",
					"minuet",
					"lazydev",
					"path",
					"snippets",
					"dadbod",
					"buffer",
					"ripgrep",
					"emoji",
				},
				per_filetype = {
					codecompanion = { "codecompanion" },
				},
				providers = {
					minuet = {
						name = "minuet",
						module = "minuet.blink",
						async = true,
						-- Should match minuet.config.request_timeout * 1000,
						-- since minuet.config.request_timeout is in seconds
						timeout_ms = 3000,
						score_offset = 50, -- Gives minuet higher priority among suggestions
					},
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
					dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
					ripgrep = {
						module = "blink-ripgrep",
						name = "Ripgrep",
						score_offset = -10,
					},
					emoji = {
						module = "blink-emoji",
						name = "Emoji",
						score_offset = 15,
						opts = { insert = true },
					},
					snippets = {
						name = "snippets",
					},
				},
			},
			cmdline = {
				keymap = {
					["<Tab>"] = { "show", "accept" },
				},
				completion = { menu = { auto_show = true } },
			},
			completion = {
				ghost_text = { enabled = true },
				trigger = {
					prefetch_on_insert = false,
					show_on_keyword = true,
				},
				menu = {
					draw = {
						columns = {
							{ "kind_icon", "label", "label_description", gap = 1 },
							{ "source_name", "kind", gap = 1 },
						},
						treesitter = { "lsp" },
						components = {
							label = {
								text = function(ctx)
									return require("colorful-menu").blink_components_text(ctx)
								end,
								highlight = function(ctx)
									return require("colorful-menu").blink_components_highlight(ctx)
								end,
							},
						},
					},
				},
				list = {
					selection = { auto_insert = true, preselect = false },
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 100,
				},
			},
		},
		opts_extend = { "sources.default" },
	},
}

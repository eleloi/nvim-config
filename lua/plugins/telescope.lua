local keys = {
	{
		"<leader>ff",
		function()
			require("telescope.builtin").find_files({
				hidden = true,
				no_ignore = false,
			})
		end,
		desc = "Files",
		mode = "n",
	},
	{
		"<leader>fa",
		"<CMD>Telescope adjacent<CR>",
		desc = "Adjacent",
		mode = "n",
	},
	{
		"<leader>fe",
		"<CMD>Telescope emoji<CR>",
		desc = "😄 Emoji",
		mode = "n",
	},
	{
		"<leader>fg",
		"<CMD>Telescope egrepify theme=get_ivy<CR>",
		desc = "Grep",
		mode = "n",
	},
	{
		"<leader>fb",
		"<CMD>Telescope builtin<CR>",
		desc = "Telescope builtins",
		mode = "n",
	},
	{
		'<leader>f"',
		"<CMD>Telescope registers<CR>",
		desc = "Registers",
		mode = "n",
	},
	{
		"<leader>fG",
		"<CMD>Telescope git_status layout_strategy=vertical<CR>",
		desc = "Git status",
		mode = "n",
	},
	{
		"<leader>st",
		"<CMD>Telescope grapple tags<CR>",
		desc = "Grapple tags",
		mode = "n",
	},
	{
		"gr",
		function()
			require("telescope.builtin").lsp_references({
				jump_type = "never",
				show_line = false,
			})
		end,
		desc = "Lsp References",
		mode = "n",
	},
	{
		"gd",
		function()
			require("telescope.builtin").lsp_definitions()
		end,
		desc = "Lsp Definition",
		mode = "n",
	},
	{
		"gt",
		function()
			require("telescope.builtin").lsp_type_definitions({ jump_type = "never" })
		end,
		desc = "Lsp Type definitions",
		mode = "n",
	},
	{
		"<leader>,",
		function()
			require("telescope.builtin").buffers({
				sort_mru = true,
				ignore_current_buffer = true,
				layout_strategy = "vertical",
			})
		end,
		desc = "Buffers",
		mode = "n",
	},
	{
		"<leader>fr",
		"<CMD>Telescope resume<CR>",
		desc = "Telescope Resume",
		mode = "n",
	},
	{
		"<leader>gb",
		"<CMD>Telescope git_branches<CR>",
		desc = "Git Branches",
		mode = "n",
	},
	{
		"<leader>fk",
		"<CMD>Telescope keymaps<CR>",
		desc = "Keymaps",
		mode = "n",
	},
	{
		"<leader>f*",
		"<CMD>Telescope grep_string theme=get_ivy<CR>",
		desc = "Grep cursor string",
		mode = "n",
	},
	{
		"<leader>fq",
		"<CMD>Telescope quickfix theme=get_ivy<CR>",
		desc = "Quickfix",
		mode = "n",
	},
	{
		"<leader>fh",
		"<CMD>Telescope help_tags theme=get_ivy<CR>",
		desc = "Help",
		mode = "n",
	},
	{
		"<leader>fj",
		function()
			require("telescope.builtin").jumplist({
				layout_strategy = "vertical",
				path_display = function(opts, path)
					local tail = require("telescope.utils").path_tail(path)
					return string.format("%s - %s", tail, path), { { { 1, #tail }, "Constant" } }
				end,
			})
		end,
		desc = "Jumplist",
		mode = "n",
	},
	{
		"<leader>fs",
		"<CMD>Telescope aerial<CR>",
		desc = "Aerial",
		mode = "n",
	},
	{
		"<leader>fS",
		"<CMD>Telescope treesitter theme=get_ivy<CR>",
		desc = "Symbols",
		mode = "n",
	},
	{
		"<leader>fo",
		"<CMD>Telescope oldfiles theme=get_ivy<CR>",
		desc = "Old files",
		mode = "n",
	},
	{
		"<leader>fi",
		"<CMD>Telescope import theme=get_ivy<CR>",
		desc = "Import",
		mode = "n",
	},
	{
		"<leader>fU",
		"<CMD>Telescope undo<CR>",
		desc = "Import",
		mode = "n",
	},
}

return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.3",
	dependencies = {
		"MaximilianLloyd/adjacent.nvim",
		"cbochs/grapple.nvim",
		"fdschmidt93/telescope-egrepify.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-lua/popup.nvim",
		"nvim-telescope/telescope-media-files.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		"nvim-telescope/telescope.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
		},
		"xiyaowong/telescope-emoji.nvim",
		"piersolenski/telescope-import.nvim",
		"stevearc/aerial.nvim",
		"debugloop/telescope-undo.nvim",
	},
	event = "VeryLazy",
	keys = keys,
	config = function()
		local actions = require("telescope.actions")
		local action_layout = require("telescope.actions.layout")

		require("telescope").setup({
			defaults = {
				prompt_prefix = "❯ ",
				selection_caret = "❯ ",

				winblend = 0,

				layout_strategy = "horizontal",
				layout_config = {
					width = 0.95,
					height = 0.85,
					prompt_position = "bottom",

					horizontal = {
						preview_width = function(_, cols, _)
							if cols > 200 then
								return math.floor(cols * 0.5)
							else
								return math.floor(cols * 0.7)
							end
						end,
					},

					vertical = { width = 0.9, height = 0.95, preview_height = 0.5 },
					flex = { horizontal = { preview_width = 0.9 } },
				},

				selection_strategy = "reset",
				sorting_strategy = "descending",
				scroll_strategy = "cycle",
				color_devicons = true,

				mappings = {
					i = {
						["<C-n>"] = "move_selection_next",
						["<M-p>"] = action_layout.toggle_preview,
						["<M-m>"] = action_layout.toggle_mirror,
						["<C-k>"] = actions.cycle_history_next,
						["<C-j>"] = actions.cycle_history_prev,
					},
				},
			},
			extensions = {
				fzy_native = {
					override_generic_sorter = true,
					override_file_sorter = true,
				},
				emoji = {
					action = function(emoji)
						vim.api.nvim_put({ emoji.value }, "c", false, true)
					end,
				},
			},
			pickers = {
				colorscheme = {
					enable_preview = true,
				},
			},
		})
		require("telescope").load_extension("media_files")
		require("telescope").load_extension("adjacent")
		require("telescope").load_extension("import")
		require("telescope").load_extension("egrepify")
		require("telescope").load_extension("aerial")
		require("telescope").load_extension("grapple")
		require("telescope").load_extension("ui-select")
		require("telescope").load_extension("undo")
		require("telescope").load_extension("emoji")
		require("telescope").load_extension("fzf")

		require("aerial").setup()
	end,
}

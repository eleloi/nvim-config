local buffer_searcher = require("config.plugins.telescope.buffer_searcher")

return {
	{
		"<leader>fF",
		function()
			require("telescope.builtin").find_files({
				hidden = true,
				no_ignore = true,
			})
		end,
		desc = "All files",
		mode = "n",
	},
	{
		"<leader>ff",
		function()
			require("telescope.builtin").find_files({
				hidden = false,
				no_ignore = false,
			})
		end,
		desc = "Files (only git)",
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
		buffer_searcher,
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
		"<CMD>Telescope help_tags<CR>",
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
	{
		"<leader>ci",
		"<cmd>Telescope hierarchy incoming_calls<cr>",
		desc = "LSP: [C]ode [I]ncoming Calls",
	},
	{
		"<leader>co",
		"<cmd>Telescope hierarchy outgoing_calls<cr>",
		desc = "LSP: [C]ode [O]utgoing Calls",
	},
}

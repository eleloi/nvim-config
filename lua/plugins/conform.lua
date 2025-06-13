local formatters = {
	lua = { "stylua" },
	python = { "ruff" },
	typescript = { "prettierd" },
	typescriptreact = { "prettierd" },
	html = { "prettierd" },
	css = { "prettierd" },
	markdown = { "prettierd" },
	go = { "goimports" },
	json = { "jq" },
	nix = { "nixfmt" },
	typ = { "typstyle" },
	typst = { "typstyle" },
}

return {
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = formatters,
			format_on_save = {
				timeout_ms = 300,
				lsp_format = "fallback",
			},
		},
		init = function()
			vim.o.formatexpr = "v:lua.require('conform').formatexpr()"
		end,
		event = "VeryLazy",
		keys = {
			{
				"<M-f>",
				function()
					require("conform").format({ lsp_format = "fallback" })
				end,
			},
		},
	},

	-- use mason tool installer to install conform tools automatically
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		lazy = false,
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			local ensure_installed = {}
			local seen = {}

			for _, tools in pairs(formatters) do
				for _, tool in ipairs(tools) do
					if not seen[tool] then
						table.insert(ensure_installed, tool)
						seen[tool] = true
					end
				end
			end
			require("mason-tool-installer").setup({
				ensure_installed = ensure_installed,
				-- if set to true this will check each tool for updates. If updates
				-- are available the tool will be updated. This setting does not
				-- affect :MasonToolsUpdate or :MasonToolsInstall.
				auto_update = true,

				-- automatically install / update on startup. If set to false nothing
				-- will happen on startup. You can use :MasonToolsInstall or
				-- :MasonToolsUpdate to install tools and check for updates.
				run_on_start = true,

				-- set a delay (in ms) before the installation starts. This is only
				-- effective if run_on_start is set to true.
				-- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
				start_delay = 3000, -- 3 second delay

				-- Only attempt to install if 'debounce_hours' number of hours has
				-- elapsed since the last time Neovim was started. This stores a
				-- timestamp in a file named stdpath('data')/mason-tool-installer-debounce.
				-- This is only relevant when you are using 'run_on_start'. It has no
				-- effect when running manually via ':MasonToolsInstall' etc....
				debounce_hours = 5, -- at least 5 hours between attempts to install/update

				integrations = {
					["mason-lspconfig"] = false,
					["mason-null-ls"] = false,
					["mason-nvim-dap"] = false,
				},
			})
		end,
	},
}

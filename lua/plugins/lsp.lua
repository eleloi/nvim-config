return {
	{
		"williamboman/mason.nvim",
		config = true,
		event = "VeryLazy",
	},
	{
		"neovim/nvim-lspconfig",
		event = "VeryLazy",
		dependencies = {
			"williamboman/mason.nvim",
			"folke/neodev.nvim",
			"davidosomething/format-ts-errors.nvim",
		},
		config = function()
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
			local on_attach = function(_, bufnr)
				local opts = { buffer = bufnr }
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "gD", function()
					vim.api.nvim_command("vsplit")
					vim.lsp.buf.definition()
				end, opts)
				vim.keymap.set("n", "<leader>cD", vim.lsp.buf.type_definition, opts)
				vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "<leader>cf", function()
					vim.lsp.buf.format({ async = true })
				end, opts)
				vim.cmd.autocmd("BufWritePre", "<buffer>", "lua vim.lsp.buf.format()")
			end

			require("neodev").setup()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({
				on_attach = on_attach,
				Lua = {
					telemetry = { enable = false },
					workspace = { checkThirdParty = false },
				},
			})
			lspconfig.eslint.setup({ on_attach = on_attach })
			lspconfig.pyright.setup({ on_attach = on_attach })
			lspconfig.ruff.setup({ on_attach = on_attach })
			lspconfig.rust_analyzer.setup({ on_attach = on_attach })
			lspconfig.gopls.setup({ on_attach = on_attach })
			lspconfig.golangci_lint_ls.setup({ on_attach = on_attach })
			lspconfig.typst_lsp.setup({ on_attach = on_attach, filetypes = { "typst", "typ" } })
			lspconfig.astro.setup({ on_attach = on_attach })
			lspconfig.bashls.setup({ on_attach = on_attach })
			vim.g.astro_typescript = "enable"
			lspconfig.ts_ls.setup({ on_attach = on_attach })
			lspconfig.svelte.setup({ on_attach = on_attach })
			lspconfig.tailwindcss.setup({ on_attach = on_attach })
			lspconfig.docker_compose_language_service.setup({ on_attach = on_attach })
			lspconfig.dockerls.setup({ on_attach = on_attach })

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true

			lspconfig.yamlls.setup({
				on_attach = on_attach,
				settings = {
					redhat = {
						telemetry = { enable = false },
					},
				},
			})

			lspconfig.taplo.setup({ on_attach = on_attach })

			lspconfig.jsonls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					json = {
						-- Schemas https://www.schemastore.org
						schemas = {
							{
								fileMatch = { "package.json" },
								url = "https://json.schemastore.org/package.json",
							},
							{
								fileMatch = { "tsconfig*.json" },
								url = "https://json.schemastore.org/tsconfig.json",
							},
							{
								fileMatch = {
									".prettierrc",
									".prettierrc.json",
									"prettier.config.json",
								},
								url = "https://json.schemastore.org/prettierrc.json",
							},
							{
								fileMatch = { ".eslintrc", ".eslintrc.json" },
								url = "https://json.schemastore.org/eslintrc.json",
							},
							{
								fileMatch = { ".babelrc", ".babelrc.json", "babel.config.json" },
								url = "https://json.schemastore.org/babelrc.json",
							},
							{
								fileMatch = { "lerna.json" },
								url = "https://json.schemastore.org/lerna.json",
							},
							{
								fileMatch = { "now.json", "vercel.json" },
								url = "https://json.schemastore.org/now.json",
							},
							{
								fileMatch = {
									".stylelintrc",
									".stylelintrc.json",
									"stylelint.config.json",
								},
								url = "http://json.schemastore.org/stylelintrc.json",
							},
						},
					},
				},
			})
		end,
	},
	{
		"dmmulroy/tsc.nvim",
		ft = { "typescript", "typescriptreact" },
		config = true,
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		config = {
			floating_window = false,
			transparency = 30,
			toggle_key = "<C-s>",
			toggle_key_flip_floatwin_setting = true,
		},
		keys = {
			{
				"<leader>cs",
				function()
					require("lsp_signature").toggle_float_win()
				end,
				desc = "Toggle Signature",
				mode = "n",
			},
		},
	},
}

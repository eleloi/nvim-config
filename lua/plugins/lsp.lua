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
			"davidosomething/format-ts-errors.nvim",
			"saghen/blink.cmp",
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

			local lspconfig = require("lspconfig")
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			lspconfig.lua_ls.setup({
				on_attach = on_attach,

				settings = { Lua = { telemetry = { enable = false } } },

				on_init = function(client)
					if client.workspace_folders then
						local path = client.workspace_folders[1].name
						if vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc") then
							return
						end
					end

					client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
						runtime = {
							version = "LuaJIT",
						},
						workspace = {
							checkThirdParty = true,
							library = {
								vim.env.VIMRUNTIME,
							},
						},
					})
				end,
			})

			lspconfig.eslint.setup({ on_attach = on_attach, capabilities = capabilities })
			lspconfig.pyright.setup({ on_attach = on_attach, capabilities = capabilities })
			lspconfig.ruff.setup({ on_attach = on_attach, capabilities = capabilities })
			lspconfig.rust_analyzer.setup({ on_attach = on_attach, capabilities = capabilities })
			lspconfig.gopls.setup({ on_attach = on_attach, capabilities = capabilities })
			lspconfig.golangci_lint_ls.setup({ on_attach = on_attach, capabilities = capabilities })
			lspconfig.tinymist.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "typst", "typ" },
			})
			lspconfig.astro.setup({ on_attach = on_attach, capabilities = capabilities })
			lspconfig.bashls.setup({ on_attach = on_attach, capabilities = capabilities })
			vim.g.astro_typescript = "enable"
			lspconfig.ts_ls.setup({ on_attach = on_attach, capabilities = capabilities })
			lspconfig.svelte.setup({ on_attach = on_attach, capabilities = capabilities })
			lspconfig.tailwindcss.setup({ on_attach = on_attach, capabilities = capabilities })
			lspconfig.docker_compose_language_service.setup({ on_attach = on_attach, capabilities = capabilities })
			lspconfig.dockerls.setup({ on_attach = on_attach, capabilities = capabilities })

			lspconfig.yamlls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = { redhat = { telemetry = { enable = false } } },
			})

			lspconfig.taplo.setup({ on_attach = on_attach, capabilities = capabilities })

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
}

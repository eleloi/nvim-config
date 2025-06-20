local lsp_tools = {
	"lua_ls",
	"rust_analyzer",
	"eslint",
	"pyright",
	"ruff",
	"gopls",
	"biome",
	"golangci_lint_ls",
	"tinymist",
	"astro",
	"bashls",
	"ts_ls",
	"svelte",
	"tailwindcss",
	"docker_compose_language_service",
	"dockerls",
	"yamlls",
	"taplo",
	"jsonls",
}

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
	vim.cmd.autocmd("BufWritePre", "<buffer>", "lua vim.lsp.buf.format()")
end

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
			local lspconfig = require("lspconfig")
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			vim.lsp.enable("nushell")
			lspconfig.nixd.setup({
				cmd = { "nixd" },
				settings = {
					nixpkgs = {
						expr = "import <nixpkgs> { }",
					},
					options = {
						nixos = {
							expr = '(builtins.getFlake "/home/eleloi/nixos-config/flake.nix").nixosConfigurations."bob".options',
						},
						home_manager = {
							expr = '(builtins.getFlake "/home/eleloi/nixos-config/flake.nix").homeConfigurations."eleloi".options',
						},
					},
				},
				on_attach = on_attach,
				capabilities = capabilities,
			})
		end,
	},

	-- use mason-lspconfig to install lsp tools automatically and setup lspconfig
	{
		"mason-org/mason-lspconfig.nvim",
		enabled = true,
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		config = function()
			vim.filetype.add({
				pattern = {
					["compose.*%.ya?ml"] = "yaml.docker-compose",
					["docker%-compose.*%.ya?ml"] = "yaml.docker-compose",
				},
			})
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next)

			local lspconfig = require("lspconfig")
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			require("mason-lspconfig").setup({
				ensure_installed = lsp_tools,
				handlers = {
					-- Default server lsp init
					function(server_name)
						lspconfig[server_name].setup({
							on_attach = on_attach,
							capabilities = capabilities,
						})
					end,
					-- Specific handlers for certain servers
					["lua_ls"] = function()
						lspconfig.lua_ls.setup({
							on_attach = on_attach,
							capabilities = capabilities,
							settings = { Lua = { telemetry = { enable = false } } },
							on_init = function(client)
								if client.workspace_folders then
									local path = client.workspace_folders[1].name
									if
										vim.uv.fs_stat(path .. "/.luarc.json")
										or vim.uv.fs_stat(path .. "/.luarc.jsonc")
									then
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
											"/home/eleloi/.config/nvim/lazy",
											"${3rd}/luv/library",
										},
									},
								})
							end,
						})
					end,

					["tinymist"] = function()
						lspconfig.tinymist.setup({
							on_attach = on_attach,
							capabilities = capabilities,
							filetypes = { "typst", "typ" },
							settings = {
								formatterMode = "typstyle",
								exportPdf = "onType",
								semanticTokens = "disable",
							},
						})
					end,

					["astro"] = function()
						vim.g.astro_typescript = "enable"
						lspconfig.astro.setup({
							on_attach = on_attach,
							capabilities = capabilities,
						})
					end,

					["bashls"] = function()
						lspconfig.bashls.setup({
							on_attach = on_attach,
							capabilities = capabilities,
							filetypes = { "bash", "sh", "zsh" },
						})
					end,

					["yamlls"] = function()
						lspconfig.yamlls.setup({
							on_attach = on_attach,
							capabilities = capabilities,
							settings = { redhat = { telemetry = { enable = false } } },
						})
					end,

					["jsonls"] = function()
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
			})
		end,
	},
	{
		"dmmulroy/tsc.nvim",
		ft = { "typescript", "typescriptreact" },
		config = true,
	},
}

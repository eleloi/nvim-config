local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local on_attach = function(client, bufnr)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ async = false })
			end,
		})
	end
end

return {
	"nvimtools/none-ls.nvim",
	event = "VeryLazy",
	enabled = true,
	dependencies = {
		"jay-babu/mason-null-ls.nvim",
		"williamboman/mason.nvim",
	},
	config = function()
		-- Setup mason-null-ls first
		require("mason-null-ls").setup({
			ensure_installed = {
				"stylua",
				"biome",
				"gomodifytags",
				"impl",
				"goimports",
				"gofumpt",
				"pg_format",
				"nixfmt",
			},
			automatic_installation = false,
			handlers = {},
		})

		-- Then setup none-ls
		local null_ls = require("null-ls")
		null_ls.setup({
			on_attach = on_attach,
		})
	end,
}

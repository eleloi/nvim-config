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
    config = function()
        local null_ls = require("null-ls")
        require("null-ls").setup({
            on_attach = on_attach,
            sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.prettierd.with({
                    extra_filetypes = { "svelte", "svg", "astro" },
                }),
                null_ls.builtins.code_actions.gomodifytags,
                null_ls.builtins.code_actions.impl,
                null_ls.builtins.formatting.goimports,
                null_ls.builtins.formatting.gofumpt,
                null_ls.builtins.formatting.pg_format,
                null_ls.builtins.formatting.nixfmt,
            },
        })
    end,
}

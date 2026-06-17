local set = vim.bo

set.tabstop = 2
set.softtabstop = 2
set.shiftwidth = 2
set.expandtab = true

vim.cmd("packadd nvim-lspconfig")
vim.lsp.config("tinymist", {
    filetypes = { "typst", "typ" },
    settings = {
        formatterMode = "typstyle",
        exportPdf = "onType",
        semanticTokens = "disable",
    },
})
vim.lsp.enable("tinymist")

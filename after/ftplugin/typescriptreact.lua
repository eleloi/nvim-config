local set = vim.bo

set.tabstop = 2
set.softtabstop = 2
set.expandtab = true
set.shiftwidth = 2

vim.cmd("packadd nvim-lspconfig")
vim.lsp.enable("eslint")
vim.lsp.enable("ts_ls")
vim.lsp.enable("tailwindcss")

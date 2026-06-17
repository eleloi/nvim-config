local set = vim.bo

set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
set.expandtab = true

vim.cmd("packadd nvim-lspconfig")
vim.lsp.enable("ruff")
vim.lsp.enable("basedpyright")

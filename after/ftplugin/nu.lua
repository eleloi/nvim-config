local set = vim.bo

set.tabstop = 2
set.softtabstop = 2
set.expandtab = true
set.shiftwidth = 2

vim.cmd("packadd nvim-lspconfig")
vim.lsp.config("nushell", {
  cmd = { "nu", "--lsp", "--no-config-file" },
})
vim.lsp.enable("nushell")

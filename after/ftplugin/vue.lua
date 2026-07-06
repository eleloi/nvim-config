if vim.b.did_ftplugin_vue then
  return
end
vim.b.did_ftplugin_vue = 1

local set = vim.bo

set.tabstop = 2
set.softtabstop = 2
set.shiftwidth = 2
set.expandtab = true

vim.cmd("packadd nvim-lspconfig")
vim.lsp.enable("eslint")
vim.lsp.enable("vtsls")
-- vim.lsp.enable("tailwindcss")
vim.lsp.enable("vue_ls")

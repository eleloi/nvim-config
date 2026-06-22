if vim.b.did_ftplugin_typ then
  return
end
vim.b.did_ftplugin_typ = 1

local set = vim.bo

set.tabstop = 2
set.softtabstop = 2
set.shiftwidth = 2
set.expandtab = true

vim.cmd("packadd nvim-lspconfig")
vim.lsp.enable("tinymist")

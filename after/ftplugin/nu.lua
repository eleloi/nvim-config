if vim.b.did_ftplugin_nu then
  return
end
vim.b.did_ftplugin_nu = 1

local set = vim.bo

set.tabstop = 2
set.softtabstop = 2
set.expandtab = true
set.shiftwidth = 2

vim.cmd("packadd nvim-lspconfig")
vim.lsp.enable("nushell")

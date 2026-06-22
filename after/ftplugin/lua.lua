if vim.b.did_ftplugin_lua then
  return
end
vim.b.did_ftplugin_lua = 1

local set = vim.bo

set.tabstop = 2
set.softtabstop = 2
set.expandtab = true
set.shiftwidth = 2

vim.cmd("packadd nvim-lspconfig")
vim.lsp.enable("lua_ls")

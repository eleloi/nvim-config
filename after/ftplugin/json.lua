if vim.b.did_ftplugin_json then
  return
end
vim.b.did_ftplugin_json = 1

vim.cmd("packadd nvim-lspconfig")

vim.lsp.enable("jsonls")

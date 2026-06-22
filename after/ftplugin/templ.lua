if vim.b.did_ftplugin_templ then
  return
end
vim.b.did_ftplugin_templ = 1

-- after/ftplugin/templ.lua
-- This file formalizes 'templ' as a known filetype for Neovim 0.11
vim.opt_local.commentstring = "// %s"

vim.cmd("packadd nvim-lspconfig")
vim.lsp.enable("templ")

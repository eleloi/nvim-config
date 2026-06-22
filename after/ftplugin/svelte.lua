if vim.b.did_ftplugin_svelte then
  return
end
vim.b.did_ftplugin_svelte = 1

local set = vim.bo

set.tabstop = 2
set.softtabstop = 2
set.expandtab = true
set.shiftwidth = 2


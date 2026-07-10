local set = vim.bo

set.autoindent = false
set.smartindent = false
set.indentexpr = ""
set.indentkeys = ""
set.tabstop = 2
set.softtabstop = 2
set.shiftwidth = 2
set.expandtab = true

vim.lsp.enable("org")

-- override keymaps
-- vim.keymap.del("n", "<leader>oli", { buffer = true })

local set = vim.bo

set.tabstop = 2
set.softtabstop = 2
set.expandtab = true
set.shiftwidth = 2

vim.opt_local.cursorcolumn = true

local group = vim.api.nvim_create_augroup("YamlCursorColumn", { clear = true })

vim.api.nvim_create_autocmd("BufEnter", {
    group = group,
    buffer = 0,
    callback = function()
        vim.opt_local.cursorcolumn = true
    end,
})

vim.api.nvim_create_autocmd("BufLeave", {
    group = group,
    buffer = 0,
    callback = function()
        vim.opt_local.cursorcolumn = false
    end,
})

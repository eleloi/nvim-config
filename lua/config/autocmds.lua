-- Auto-load changes when file is modified externally
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
    command = "if mode() != 'c' && getcmdwintype() == '' | checktime | endif",
    pattern = { "*" },
})

-- highlight on yank
vim.cmd("au TextYankPost * lua vim.hl.on_yank {on_visual = false}")

-- detect .typ as typst
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.typ" },
    callback = function()
        vim.bo.filetype = "typst"
    end,
})

-- detect .hurl as hurl
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.hurl" },
    callback = function()
        vim.bo.filetype = "hurl"
    end,
})

-- disable automatic comment on newline
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        vim.opt_local.formatoptions:remove({ "c", "r", "o" })
    end,
})

-- format on save using lsp
-- Formateo automático al guardar usando el LSP nativo
vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = true }),
    callback = function(args)
        vim.lsp.buf.format({ bufnr = args.buf })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "*.bash", "*.sh", "*.zsh" },
    callback = function()
        vim.cmd("packadd nvim-lspconfig")
        vim.lsp.enable("bashls")
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "*Dockerfile" },
    callback = function()
        vim.cmd("packadd nvim-lspconfig")
        vim.lsp.enable("dockerls")
    end,
})

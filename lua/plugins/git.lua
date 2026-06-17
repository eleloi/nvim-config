vim.pack.add({
    "https://github.com/rafikdraoui/jj-diffconflicts",
    "https://github.com/lewis6991/gitsigns.nvim",
    "https://github.com/wintermute-cell/gitignore.nvim",
})

require("gitsigns").setup({
    signcolumn = false, -- Don't use a separate sign column
    numhl = true,    -- Highlight line number
    linehl = false,
    word_diff = false,
    max_file_length = 10000,
})

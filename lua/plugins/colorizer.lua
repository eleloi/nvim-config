vim.pack.add({
    "https://github.com/norcalli/nvim-colorizer.lua",
    "https://github.com/roobert/tailwindcss-colorizer-cmp.nvim",
})

require("colorizer").setup({
    "css",
    "javascript",
    "typesciprt",
    "javascriptreact",
    "typescriptreact",
    "html",
    "lua",
    "python",
    "json",
    "conf",
})

require("tailwindcss-colorizer-cmp").setup({
    color_square_width = 2,
})

-- View colors in certain files
return {
    {
        "norcalli/nvim-colorizer.lua",
        event = "VeryLazy",
        config = function()
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
        end,
    },
    {
        "roobert/tailwindcss-colorizer-cmp.nvim",
        -- optionally, override the default options:
        config = function()
            require("tailwindcss-colorizer-cmp").setup({
                color_square_width = 2,
            })
        end,
    },
}

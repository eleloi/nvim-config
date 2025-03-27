-- Improve markdown view

return {
    "OXY2DEV/markview.nvim",
    ft = { "markdown", "vimwiki" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        vim.treesitter.language.register("markdown", { "vimwiki" })
        require("markview").setup({
            preview = {
                filetypes = { "markdown", "vimwiki" },
            }
        })
        vim.cmd("Markview Disable")
    end,
}

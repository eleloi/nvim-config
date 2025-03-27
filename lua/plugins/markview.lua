-- Improve markdown view

return {
    "OXY2DEV/markview.nvim",
    ft = { "markdown", "vimwiki" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local preset = require("markview.presets")
        vim.treesitter.language.register("markdown", { "vimwiki" })
        require("markview").setup({
            preview = {
                filetypes = { "markdown", "vimwiki" },
            },
            markdown = {
                headings = preset.headings.glow,
                tables = preset.tables.none
            },

        })
        vim.cmd("Markview Disable")
    end,
}

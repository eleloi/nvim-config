-- Improve markdown view

return {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "Avante", "vimwiki", "codecompanion" },
    config = function()
        vim.g.render_markdown_enable = true
        vim.treesitter.language.register("markdown", "vimwiki")
        require("render-markdown").setup({
            file_types = { "markdown", "Avante", "vimwiki", "codecompanion" },
        })
    end,
}

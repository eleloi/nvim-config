-- Improve markdown view

return {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "Avante", "codecompanion" },
    config = function()
        vim.g.render_markdown_enable = true
        require("render-markdown").setup({
            file_types = { "markdown", "Avante", "codecompanion" },
        })
    end,
}

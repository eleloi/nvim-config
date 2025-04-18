-- Improve markdown view

return {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { "markdown", "Avante", "vimwiki" },
    config = function()
        vim.g.render_markdown_enable = true
        vim.treesitter.language.register("markdown", "vimwiki")
        require("render-markdown").setup({
            file_types = { "markdown", "Avante", "vimwiki" },
        })
    end
}

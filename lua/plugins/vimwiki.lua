return {
    {
        "vimwiki/vimwiki",
        -- event = "BufEnter *.md",
        event = "VeryLazy",
        keys = { {
            "<leader>ww",
            "<cmd>VimwikiIndex<cr>",
            desc = "Vimwiki Index"
        }, {
            "<leader>wd",
            "<cmd>VimwikiMakeDiaryNote<cr>",
            desc = "Vimwiki Make Diary Note"

        } },
        -- The configuration for the plugin
        init = function()
            vim.g.vimwiki_global_ext = 0
            vim.g.vimwiki_list = {
                {
                    path = "~/Nextcloud/Notes/",
                    syntax = "markdown",
                    ext = "md",
                },
            }
        end,
    },
    {
        "tools-life/taskwiki",
        event = "VeryLazy",
    }
}

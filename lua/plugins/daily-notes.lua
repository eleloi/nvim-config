return {
    {
        "pankajgarkoti/daily-notes.nvim",
        config = function()
            require("daily-notes").setup({
                base_dir = "~/Documents/vimwiki",                   -- Your notes directory
                journal_path = "Daily",                             -- Subdirectory for daily notes
                template_path = "~/Documents/vimwiki/Daily/templates/daily.md", -- Optional template
                -- Example of ignoring a header
                -- ignored_headers = { "To-Do" },
            })
        end,
        keys = {
            {
                "<leader>w<leader>w",
                function()
                    require("daily-notes").open_daily_note()
                end,
                desc = "Open daily note",
            },
            {
                "<leader>w",
                function()
                    vim.cmd("edit ~/Documents/vimwiki/index.md")
                end,
            },
            -- {
            --     "<leader>dk",
            --     function()
            --         require("daily-notes").open_adjacent_note(-1)
            --     end,
            --     desc = "Previous daily note",
            -- },
            -- {
            --     "<leader>dj",
            --     function()
            --         require("daily-notes").open_adjacent_note(1)
            --     end,
            --     desc = "Next daily note",
            -- },
            -- {
            --     "<leader>dm",
            --     function()
            --         require("daily-notes").create_tomorrow_note()
            --     end,
            --     desc = "Create tomorrow's note",
            -- },
            -- {
            --     "<leader>dc",
            --     function()
            --         require("daily-notes").configure_interactive()
            --     end,
            --     desc = "Configure daily notes",
            -- },
            -- {
            --     "<leader>ts",
            --     function()
            --         require("daily-notes").insert_timestamp()
            --     end,
            --     desc = "Insert timestamp",
            -- },
            -- {
            --     "<leader>T",
            --     function()
            --         require("daily-notes").insert_timestamp(true)
            --     end,
            --     desc = "Insert timestamp on new line",
            -- },
        },
        cmd = {
            "DailyNote",
            "DailyNotePrev",
            "DailyNoteNext",
            "DailyNoteTomorrow",
            "DailyNoteConfig",
            "DailyNoteTimestamp",
        },
    },
}

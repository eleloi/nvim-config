-- Find and repalce in all workspace

return {
    "MagicDuck/grug-far.nvim",
    -- Note (lazy loading): grug-far.lua defers all it's requires so it's lazy by default
    -- additional lazy config to defer loading is not really needed...

    keys = {
        {
            "<leader>*",
            "<cmd>GrugFar<cr>",
            desc = "Search and replace",
            mode = { "n" },
        },
        {
            "<leader>*",
            function()
                require("grug-far").with_visual_selection({
                    transient = true,
                    startInInsertMode = false,
                    startCursorRow = 1,
                })
            end,
            desc = "Search and replace",
            mode = { "v" },
        },
    },
    config = function()
        require("grug-far").setup({
            keymaps = {
                replace = { n = "<leader>r" },
                qflist = { n = "<leader>q" },
                syncLocations = { n = "<leader>s" },
                syncLine = { n = "<leader>l" },
                close = { n = "<leader>c" },
                historyOpen = { n = "<leader>t" },
                historyAdd = { n = "<leader>a" },
                refresh = { n = "<leader>f" },
                openLocation = { n = "<leader>o" },
                openNextLocation = { n = "<down>" },
                openPrevLocation = { n = "<up>" },
                gotoLocation = { n = "<enter>" },
                pickHistoryEntry = { n = "<enter>" },
                abort = { n = "<leader>b" },
                help = { n = "g?" },
                toggleShowCommand = { n = "<leader>w" },
                swapEngine = { n = "<leader>e" },
                previewLocation = { n = "<leader>i" },
                swapReplacementInterpreter = { n = "<leader>x" },
                applyNext = { n = "<leader>j" },
                applyPrev = { n = "<leader>k" },
                syncNext = { n = "<leader>n" },
                syncPrev = { n = "<leader>p" },
                syncFile = { n = "<leader>v" },
                nextInput = { n = "<tab>" },
                prevInput = { n = "<s-tab>" },
            },
        })
    end,
}

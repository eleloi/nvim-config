return {
    -- lazy.nvim
    "chrisgrieser/nvim-origami",
    event = "VeryLazy",
    opts = {
        useLspFoldsWithTreesitterFallback = true,
        pauseFoldsOnSearch = true,
        foldtext = {
            enabled = true,
            padding = 3,
            lineCount = {
                template = "↔️ %d", -- `%d` is replaced with the number of folded lines
                hlgroup = "Conceal",
            },
            diagnosticsCount = true, -- uses hlgroups and icons from `vim.diagnostic.config().signs`
            gitsignsCount = true, -- requires `gitsigns.nvim`
        },
        autoFold = {
            enabled = true,
            kinds = { "comment", "imports" }, ---@type lsp.FoldingRangeKind[]
        },
        foldKeymaps = {
            setup = false,
            hOnlyOpensOnFirstColumn = false,
        },
    },

    init = function()
        vim.opt.foldlevel = 99
        vim.opt.foldlevelstart = 99
    end,

    config = function(_, opts)
        require("origami").setup(opts)

        -- vim.keymap.set("n", "<Left>", function()
        --     require("origami").h()
        -- end)
        --
        -- vim.keymap.set("n", "<Right>", function()
        --     require("origami").l()
        -- end)

        -- Keymaps
        vim.keymap.set("n", "z1", "zMzr", {
            desc = "Fold all, then open 1 level",
        })
        vim.keymap.set("n", "z2", "zMzrzr", {
            desc = "Fold all, then open 2 levels",
        })
        vim.keymap.set("n", "z3", "zMzrzrzr", {
            desc = "Fold all, then open 3 levels",
        })
        vim.keymap.set("n", "z4", "zMzrzrzrzr", {
            desc = "Fold all, then open 4 levels",
        })
        vim.keymap.set("n", "z5", "zMzrzrzrzrzr", {
            desc = "Fold all, then open 5 levels",
        })
    end,
}

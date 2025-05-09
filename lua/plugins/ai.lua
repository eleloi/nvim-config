return {
    {
        "Exafunction/codeium.vim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        event = "BufEnter",
        config = function()
            vim.g.codeium_enabled = true
        end,
        keys = {
            {
                "<M-l>",
                function()
                    return vim.fn["codeium#Accept"]()
                end,
                expr = true,
                desc = "Accpet codeium",
                mode = { "i" },
            },
            {
                "<M-j>",
                function()
                    return vim.fn["codeium#CycleCompletions"](1)
                end,
                expr = true,
                desc = "Cycle completions fwd",
                mode = { "i" },
            },
            {
                "<M-k>",
                function()
                    return vim.fn["codeium#CycleCompletions"](-1)
                end,
                expr = true,
                desc = "Cycle completions bwd",
                mode = { "i" },
            },
            {
                "<M-e>",
                function()
                    return vim.fn["codeium#Clear"]()
                end,
                expr = true,
                desc = "Clear codeium",
                mode = { "i" },
            },
        },
    },
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        version = false, -- set this to "*" if you want to always pull the latest change, false to update on release
        build = "make",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
        },
        opts = {
            provider = "claude",
            claude = {
                model = "claude-3-7-sonnet-20250219",
                -- disable_tools = true, -- Disable tools for now (it's enabled by default) as it's causing rate-limit problems with Claude, see more here: https://github.com/yetone/avante.nvim/issues/1384
                disable_tools = { "python" }
            },
            behaviour = {
                auto_suggestions = false,
            },
            mappings = {
                --- @class AvanteConflictMappings
                diff = {
                    ours = "co",
                    theirs = "ct",
                    all_theirs = "ca",
                    both = "cb",
                    cursor = "cc",
                    next = "]x",
                    prev = "[x",
                },
                suggestion = {
                    accept = "<M-l>",
                    next = "<M-]>",
                    prev = "<M-[>",
                    dismiss = "<C-]>",
                },
                jump = {
                    next = "]]",
                    prev = "[[",
                },
                submit = {
                    normal = "<CR>",
                    insert = "<C-s>",
                },
                sidebar = {
                    apply_all = "A",
                    apply_cursor = "a",
                    switch_windows = "<Tab>",
                    reverse_switch_windows = "<S-Tab>",
                },
            },
        },
    },
}

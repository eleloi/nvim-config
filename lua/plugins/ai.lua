return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                panel = { enabled = false },
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    hide_during_completion = false,
                    debounce = 75,
                    trigger_on_accept = true,
                    keymap = {
                        accept = "<M-l>",
                        accept_word = "<M-;>",
                        accept_line = false,
                        next = "<M-j>",
                        prev = "<M-k>",
                        dismiss = "<C-e>",
                    },
                },
                filetypes = {
                    yaml = true,
                    markdown = true,
                    help = false,
                    gitcommit = true,
                    gitrebase = false,
                    hgcommit = false,
                    svn = false,
                    cvs = true,
                    ["."] = true,
                },
            })
        end,
    },
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        keys = {
            {
                "<leader>at",
                function()
                    require("codecompanion").toggle()
                end,
                desc = "Code Companion Chat toggle",
            },
        },
        config = function()
            require("codecompanion").setup({
                strategies = {
                    chat = {
                        keymaps = {
                            send = {
                                modes = { n = "<C-s>", i = "<C-s>" },
                            },
                            close = {
                                modes = { n = "<C-c>", i = "<C-c>" },
                            },
                        },
                    },
                },
                extensions = {
                    mcphub = {
                        callback = "mcphub.extensions.codecompanion",
                        opts = {
                            show_result_in_chat = true, -- Show mcp tool results in chat
                            make_vars = true, -- Convert resources to #variables
                            make_slash_commands = true, -- Add prompts as /slash commands
                        },
                    },
                },
            })
        end,
    },
    {
        "ravitemer/mcphub.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        build = "bundled_build.lua",
        config = function()
            require("mcphub").setup({
                use_bundled_binary = true,
            })
        end,
    },
}

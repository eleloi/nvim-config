return {
    {
        "milanglacier/minuet-ai.nvim",
        enabled = true,
        config = function()
            vim.g.aicompletion_enable = true
            require("minuet").setup({
                provider = "claude",
                provider_options = {
                    gemini = {
                        model = "gemini-2.0-flash",
                        optional = {
                            generationConfig = {
                                maxOutputTokens = 256,
                                -- When using `gemini-2.5-flash`, it is recommended to entirely
                                -- disable thinking for faster completion retrieval.
                                thinkingConfig = {
                                    thinkingBudget = 0,
                                },
                            },
                            safetySettings = {
                                {
                                    -- HARM_CATEGORY_HATE_SPEECH,
                                    -- HARM_CATEGORY_HARASSMENT
                                    -- HARM_CATEGORY_SEXUALLY_EXPLICIT
                                    category = "HARM_CATEGORY_DANGEROUS_CONTENT",
                                    -- BLOCK_NONE
                                    threshold = "BLOCK_ONLY_HIGH",
                                },
                            },
                        },
                    },
                    claude = {
                        max_tokens = 512,
                        model = "claude-3-5-haiku-20241022",
                    },
                },
                blink = {
                    enable_auto_complete = true,
                },
                virtualtext = {
                    auto_trigger_ft = { "*" },
                    keymap = {
                        -- accept whole completion
                        accept = "<M-l>",
                        -- accept one line
                        accept_line = "<M-;>",
                        prev = "<M-k>",
                        -- Cycle to next completion item, or manually invoke completion
                        next = "<M-j>",
                        dismiss = "<M-e>",
                    },
                    show_on_completion_menu = true,
                },
            })
        end,
    },
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        enabled = false,
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
        event = "VeryLazy",
        keys = {
            {
                "<leader>at",
                function()
                    require("codecompanion").toggle()
                end,
                mode = { "v", "n" },
                desc = "Code Companion Chat toggle",
            },
            {
                "<leader>aa",
                "<CMD>CodeCompanionActions<CR>",
                mode = { "v", "n" },
                desc = "Code Companion Actions",
            },
            {
                "<leader>ad",
                "<CMD>CodeCompanionChat Add<CR>",
                mode = { "v" },
                desc = "Add visually selected chat to the current chat buffer",
            },
            {
                "<leader>ac",
                "<CMD>CodeCompanion /commit<CR>",
                desc = "Generate commit message from staged diff",
            },
        },
        config = function()
            require("codecompanion").setup({
                adapters = {
                    anthropic = function()
                        return require("codecompanion.adapters").extend("anthropic", {
                            schema = {
                                model = {
                                    default = "claude-sonnet-4-20250514",
                                },
                            },
                        })
                    end,
                },
                strategies = {
                    chat = {
                        adapter = "anthropic",
                        keymaps = {
                            send = {
                                modes = { n = "<CR>", i = "<C-s>" },
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
                    vectorcode = {
                        opts = {
                            add_tool = true,
                        },
                    },
                },
            })
            vim.cmd([[cab cc CodeCompanion]])
        end,
    },
    {
        "Davidyz/VectorCode",
        version = "*", -- optional, depending on whether you're on nightly or release
        dependencies = { "nvim-lua/plenary.nvim" },
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

return {
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
        "nickjvandyke/opencode.nvim",
        version = "*",
        dependencies = {
            {
                "folke/snacks.nvim",
                optional = true,
                opts = {
                    input = {},
                    picker = {
                        actions = {
                            opencode_send = function(...)
                                return require("opencode").snacks_picker_send(...)
                            end,
                        },
                        win = {
                            input = {
                                keys = {
                                    ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
                                },
                            },
                        },
                    },
                },
            },
        },
        config = function()
            vim.g.opencode_opts = {}
            vim.o.autoread = true

            vim.keymap.set({ "n", "x" }, "<leader>aa", function()
                require("opencode").ask("@this: ", { submit = true })
            end, { desc = "Ask opencode…" })
            vim.keymap.set({ "n", "x" }, "<leader>ax", function()
                require("opencode").select()
            end, { desc = "Execute opencode action…" })
            vim.keymap.set({ "n", "t" }, "<leader>at", function()
                require("opencode").toggle()
            end, { desc = "Toggle opencode" })

            vim.keymap.set({ "n", "x" }, "go", function()
                return require("opencode").operator("@this ")
            end, { desc = "Add range to opencode", expr = true })
            vim.keymap.set("n", "goo", function()
                return require("opencode").operator("@this ") .. "_"
            end, { desc = "Add line to opencode", expr = true })
        end,
    },
    {
        "Exafunction/windsurf.nvim",
        event = "VeryLazy",
        enabled = true,
        config = function()
            require("codeium").setup({
                -- Optionally disable cmp source if using virtual text only
                enable_cmp_source = false,
                virtual_text = {
                    enabled = true,
                    -- These are the defaults
                    -- Set to true if you never want completions to be shown automatically.
                    manual = false,
                    idle_delay = 75,
                    map_keys = true,
                    -- The key to press when hitting the accept keybinding but no completion is showing.
                    -- Defaults to \t normally or <c-n> when a popup is showing.
                    accept_fallback = nil,
                    -- Key bindings for managing completions in virtual text mode.
                    key_bindings = {
                        -- Accept the current completion.
                        accept = "<M-l>",
                        -- Accept the next word.
                        accept_word = "<M-;>",
                        -- Accept the next line.
                        accept_line = false,
                        -- Clear the virtual text.
                        clear = false,
                        -- Cycle to the next completion.
                        next = "<M-j>",
                        -- Cycle to the previous completion.
                        prev = "<M-k>",
                    },
                },
            })
        end,
    },
}

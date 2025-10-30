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
                strategies = {
                    chat = {
                        adapter = {
                            name = "gemini",
                            model = "gemini-2.5-flash",
                        },
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
                adapters = {
                    http = {
                        gemini = function()
                            return require("codecompanion.adapters").extend("gemini", {
                                env = {
                                    api_key = "cmd:bash -c 'echo $GEMINI_API_KEY'",
                                },
                            })
                        end,
                    },
                },
                prompt_library = {
                    ["build git commits"] = {
                        strategy = "chat",
                        description =
                        "Given a git diff, group related changes into logical hunks and generate concise, descriptive commit messages for each group.",
                        prompts = {
                            {
                                role = "system",
                                content =
                                "You are an experienced developer. You are skilled at analyzing git diffs and writing clear, conventional commit messages.",
                            },
                            {
                                role = "user",
                                content = function()
                                    local handle = io.popen("git diff")
                                    if not handle then
                                        return "Unable to retrieve git diff."
                                    end
                                    local git_diff = handle:read("*a")
                                    handle:close()

                                    if not git_diff or git_diff == "" then
                                        return "No unstaged changes found."
                                    end
                                    return string.format(
                                        [[
Here is the output of a git diff:

```diff
%s
```

Please analyze the diff, group related changes into logical hunks, and for each group, write a concise and descriptive commit message. If multiple commits are needed, provide a commit message for each group. Use best practices for commit message formatting.
]],
                                        git_diff
                                    )
                                end,
                            },
                        },
                    },
                    ["resume link contents"] = {
                        strategy = "chat",
                        opts = {
                            modes = { "v" },
                            contains_code = true,
                        },
                        condition = function(context)
                            return context.is_visual
                        end,
                        description =
                        "Summarize the contents of a web page given its link, providing a concise and informative overview.",
                        prompts = {
                            {
                                role = "system",
                                content =
                                "You are a helpful assistant skilled at browsing web pages and summarizing their content. When given a link, you will navigate to the page, analyze its main topics, and provide a clear, concise summary that highlights the most important information. Avoid copying large sections verbatim; instead, focus on the key points and overall purpose of the page.",
                            },
                            {
                                role = "user",
                                content = string.format([[
Please visit the following link using @mcp fetch. After reviewing the page, write a brief summary, of max 2 lines, but idealy 1, that captures its main ideas and purpose.

Give the result in code format, between ``` symbols
]]),
                            },
                        },
                    },
                },
            })
            vim.cmd([[cab cc CodeCompanion]])
        end,
    },
    {
        "Exafunction/windsurf.nvim",
        event = "VeryLazy",
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

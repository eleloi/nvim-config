vim.pack.add({
    "https://github.com/Exafunction/windsurf.nvim",
    "https://github.com/nvim-lua/plenary.nvim", -- dependency
})

require("codeium").setup({
    -- Optionally disable cmp source if using virtual text only
    enable_cmp_source = false,
    quiet = true,
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

vim.pack.add({
    "https://github.com/folke/which-key.nvim",
})

require("which-key").setup({
    preset = "modern",
    delay = 500, -- Shorter delay for responsiveness
    win = {
        border = "rounded",
        padding = { 1, 2 },
    },
    spec = {
        -- { "<leader>R", desc = "Reload configuration", icon = "󰑓 " },
        -- { "<leader>a", group = "ai", icon = "󰧑 " },
        -- { "<leader>b", group = "buffer", icon = "󰓩 " },
        -- { "<leader>c", group = "code", icon = "󰅱 " },
        -- { "<leader>d", group = "debug", icon = "󰃤 " },
        -- { "<leader>f", group = "find", icon = "󰍉 " },
        -- { "<leader>g", group = "git", icon = "󰊢 " },
        -- { "<leader>h", group = "http/rest", icon = "󰖟 " },
        -- { "<leader>s", group = "harpoon", icon = "󱗓 " },
        -- { "<leader>u", group = "ui", icon = "󰙵 " },
        -- { "<leader>w", group = "save", icon = "󰆓 " },
        -- { "<leader>x", group = "funny", icon = "󰃥 " },
        -- { "g", group = "goto", icon = "󰈇 " },
    },
})

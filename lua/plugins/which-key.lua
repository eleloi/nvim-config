return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            preset = "modern", -- Estilo limpio y moderno
            delay = 500, -- Reducimos el retardo para que sea más ágil
            win = {
                border = "rounded",
                padding = { 1, 2 },
            },
            spec = {
                { "<leader>R", desc = "Reload configuration", icon = "󰑓 " },
                { "<leader>a", group = "ai", icon = "󰧑 " },
                { "<leader>b", group = "buffer", icon = "󰓩 " },
                { "<leader>c", group = "code", icon = "󰅱 " },
                { "<leader>f", group = "find", icon = "󰍉 " },
                { "<leader>g", group = "git", icon = "󰊢 " },
                { "<leader>h", group = "http/rest", icon = "󰖟 " },
                { "<leader>s", group = "harpoon", icon = "󱗓 " },
                { "<leader>u", group = "ui", icon = "󰙵 " }, -- Tu nuevo grupo de UI
                { "<leader>w", group = "save", icon = "󰆓 " },
                { "<leader>x", group = "funny", icon = "󰃥 " },
                { "g", group = "goto", icon = "󰈇 " },
            },
        },
        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)
        end,
    },
    { "meznaric/key-analyzer.nvim", opts = {} },
}

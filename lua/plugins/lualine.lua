vim.pack.add({
    "https://github.com/nvim-lualine/lualine.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons", -- dependency
})

require("lualine").setup({
    options = {
        theme = "auto",
        icons_enabled = true,
        globalstatus = true,
    },
    extensions = { "quickfix" },
    sections = {
        lualine_a = { { "mode", upper = true } },
        lualine_b = {
            { "branch", icon = "" },
            "db_ui#statusline",
        },
        lualine_c = { { "filename", file_status = true, path = 1 } },
        lualine_x = {
            "diagnostics",
            "diff",
        },
        lualine_y = { "filetype" },
        lualine_z = { "location" },
    },
    winbar = {
        lualine_a = {},
        lualine_b = {},
        inactive_lualine_c = { { "filename", file_status = true, path = 1 } },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
    inactive_winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
})

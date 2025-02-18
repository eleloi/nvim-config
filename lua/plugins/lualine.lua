return {
    "nvim-lualine/lualine.nvim",
    requires = { "nvim-tree/nvim-web-devicons", opt = true },
    event = "VeryLazy",
    config = function()
        require("lualine").setup({
            options = {
                theme = "auto",
                icons_enabled = true,
                globalstatus = true,
            },
            extensions = { "quickfix", "fugitive" },
            sections = {
                lualine_a = { { "mode", upper = true } },
                lualine_b = {
                    { "branch", icon = "" },
                    "db_ui#statusline",
                },
                lualine_c = { { "filename", file_status = true, path = 1 } },
                lualine_x = {
                    {
                        function()
                            return vim.g.codeium_enabled and "🧠 " or ""
                        end,
                        color = { fg = "ff9e64" },
                    },
                    "diagnostics",
                    "diff",
                    {
                        require("lazy.status").updates,
                        cond = require("lazy.status").has_updates,
                        color = { fg = "ff9e64" },
                    },
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
                lualine_c = { { "filename", file_status = true, path = 1 } },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
        })
    end,
}

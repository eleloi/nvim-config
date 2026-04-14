return {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    opts = {
        enable = false,
        multiwindow = false,
        max_lines = 0, -- 0 for no limit
        min_window_height = 0,
        line_numbers = true,
        multiline_threshold = 20,
        trim_scope = "outer",
        mode = "cursor",
        separator = nil,
        zindex = 20,
        on_attach = nil,
    },
    config = true,
}

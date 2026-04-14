return {
    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
        opts = {
            input = {
                border = "rounded",
                relative = "cursor",
                prefer_width = 40,
            },
            select = {
                backend = { "telescope", "fzf_lua", "builtin" },
                trim_prompt = true,
                builtin = {
                    border = "rounded",
                    relative = "cursor",
                },
            },
        },
    },
    {
        "b0o/incline.nvim",
        event = "BufReadPre",
        priority = 1200,
        config = function()
            local helpers = require("incline.helpers")
            require("incline").setup({
                window = {
                    margin = { horizontal = 0, vertical = 0 },
                    padding = 0,
                },
                render = function(props)
                    -- Only show if window is not focused
                    if props.focused then
                        return ""
                    end

                    local full_path = vim.api.nvim_buf_get_name(props.buf)
                    local filename = vim.fn.fnamemodify(full_path, ":t")
                    -- Get relative path for display
                    local relative_path = vim.fn.fnamemodify(full_path, ":.")

                    if filename == "" then
                        return { { "[No Name]", gui = "italic" } }
                    end

                    local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
                    local modified = vim.bo[props.buf].modified and " ●" or ""

                    -- Differentiate directory and filename colors
                    local dirname = vim.fn.fnamemodify(relative_path, ":h")
                    if dirname == "." then
                        dirname = ""
                    else
                        dirname = dirname .. "/"
                    end

                    return {
                        { (ft_icon or "") .. " ", guifg = ft_color },
                        { dirname,                guifg = "#808080" },
                        { filename,               gui = "bold" },
                        { modified,               guifg = "#e67e80" },
                        { " ",                    guibg = "none" },
                    }
                end,
            })
        end,
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = "BufReadPost",
        opts = {
            signs = true,
            keywords = {
                FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
                TODO = { icon = " ", color = "info" },
                HACK = { icon = " ", color = "warning" },
                WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
                PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
                NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
            },
            highlight = {
                multiline = true,
                multiline_pattern = "^.",
                multiline_context = 10,
                before = "",
                keyword = "wide",
                after = "fg",
                -- Match standard keyword format (KEYWORD:)
                pattern = [[.*<(KEYWORDS)\s*:]],
                comments_only = true,
            },
        },
    },
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy",
        priority = 1000, -- Higher priority to override defaults
        config = function()
            require("tiny-inline-diagnostic").setup({
                signs = {
                    left = "",
                    right = "",
                    diag = "",
                    arrow = "  ",
                    up_arrow = "  ",
                    vertical = " │",
                    vertical_end = " └",
                },
                blend = {
                    factor = 0.2,
                },
                options = {
                    show_source = true, -- Show diagnostic source
                    use_icons_from_diagnostic = true,
                    add_padding = true,
                    multilines = {
                        enabled = true,
                        always_show = false, -- Only show multiline when needed
                    },
                    show_all_diags_on_line = false, -- One diagnostic per line
                },
            })
            -- Start disabled; use toggle to enable
            -- Keep standard virtual text enabled
            require("tiny-inline-diagnostic").disable()
        end,
    },
    {
        "Wansmer/symbol-usage.nvim",
        event = "LspAttach",
        config = function()
            require("symbol-usage").setup({
                text_format = function(symbol)
                    local res = {}
                    if symbol.references then
                        local usage = symbol.references > 0 and ("󰈇 %d refs"):format(symbol.references)
                            or "󰈇 0 refs"
                        table.insert(res, usage)
                    end
                    if symbol.definitions then
                        local defs = symbol.definitions > 0 and ("󰡱 %d defs"):format(symbol.definitions) or ""
                        if defs ~= "" then
                            table.insert(res, defs)
                        end
                    end
                    if symbol.implementations then
                        local impls = symbol.implementations > 0 and ("󰡱 %d impls"):format(symbol.implementations)
                            or ""
                        if impls ~= "" then
                            table.insert(res, impls)
                        end
                    end
                    return table.concat(res, " | ")
                end,
                hl = { link = "Comment" },
                vt_position = "above", -- Metadata style position
            })
            require("symbol-usage").toggle_globally()
        end,
    },
}

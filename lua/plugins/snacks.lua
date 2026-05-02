local keys = require("config.plugins.snacks.keys")

---@class snacks.indent.Config
---@field enabled? boolean
local indent_config = {
    indent = {
        priority = 1,
        enabled = false, -- enable indent guides
        char = "│",
        only_scope = true, -- only show indent guides of the scope
        only_current = true, -- only show indent guides in the current window
        -- hl = "SnacksIndent", ---@type string|string[] hl groups for indent guides
        -- can be a list of hl groups to cycle through
        hl = {
            "SnacksIndent1",
            "SnacksIndent2",
            "SnacksIndent3",
            "SnacksIndent4",
            "SnacksIndent5",
            "SnacksIndent6",
            "SnacksIndent7",
            "SnacksIndent8",
        },
    },
    -- animate scopes. Enabled by default for Neovim >= 0.10
    -- Works on older versions but has to trigger redraws during animation.
    ---@class snacks.indent.animate: snacks.animate.Config
    ---@field enabled? boolean
    --- * out: animate outwards from the cursor
    --- * up: animate upwards from the cursor
    --- * down: animate downwards from the cursor
    --- * up_down: animate up or down based on the cursor position
    ---@field style? "out"|"up_down"|"down"|"up"
    animate = {
        enabled = vim.fn.has("nvim-0.10") == 1,
        style = "up_down",
        easing = "linear",
        duration = {
            step = 20, -- ms per step
            total = 300, -- maximum duration
        },
    },
    ---@class snacks.indent.Scope.Config: snacks.scope.Config
    scope = {
        enabled = true, -- enable highlighting the current scope
        priority = 200,
        char = "│",
        underline = false, -- underline the start of the scope
        only_current = false, -- only show scope in the current window
        hl = "SnacksIndentScope", ---@type string|string[] hl group for scopes
    },
    chunk = {
        -- when enabled, scopes will be rendered as chunks, except for the
        -- top-level scope which will be rendered as a scope.
        enabled = true,
        -- only show chunk scopes in the current window
        only_current = false,
        priority = 200,
        -- hl = "SnacksIndentChunk", ---@type string|string[] hl group for chunk scopes
        hl = {
            "SnacksIndent1",
            "SnacksIndent2",
            "SnacksIndent3",
            "SnacksIndent4",
            "SnacksIndent5",
            "SnacksIndent6",
            "SnacksIndent7",
            "SnacksIndent8",
        },
        char = {
            -- corner_top = "┌",
            -- corner_bottom = "└",
            corner_top = "╭",
            corner_bottom = "╰",
            horizontal = "─",
            vertical = "│",
            arrow = ">",
        },
    },
    -- filter for buffers to enable indent guides
    filter = function(buf)
        return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == ""
    end,
}

return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = keys,
    ---@type snacks.Config
    opts = {
        bigfile = {
            enabled = true,
            size = 10 * 1024 * 1024, -- 10 MB
        },
        bufdelete = { enabled = true },
        quickfile = { enabled = true },
        indent = indent_config,
        input = { enabled = false },
        notifier = { enabled = true },
        scroll = { enabled = true },
        scratch = { enabled = true },
        statuscolumn = {
            enabled = true,
            left = { "mark", "sign" }, -- Combined signs (marks and diagnostics)
            right = { "number" },
            folds = {
                open = false,
                git_hl = true, -- Highlight line number with Git color
            },
        },
        toggle = { enabled = true },
        words = {
            enabled = false,
            jumplist = false,
            modes = { "n" },
        },
        zen = { enabled = true },
        dashboard = {
            enabled = true,
            sections = {
                {
                    text = [[
 ███████████████████████████
 ███████▀▀▀░░░░░░░▀▀▀███████
 ████▀░░░░░░░░░░░░░░░░░▀████
 ███│░░░░░░░░░░░░░░░░░░░│███
 ██▌│░░░░░░░░░░░░░░░░░░░│▐██
 ██░└┐░░░░░░░░░░░░░░░░░┌┘░██
 ██░░└┐░░░░░░░░░░░░░░░┌┘░░██
 ██░░┌┘▄▄▄▄▄░░░░░▄▄▄▄▄└┐░░██
 ██▌│░██████▌░░░▐██████│░▐██
 ███░│▐███▀▀░░▄░░▀▀███▌│░███
 ██▀─┘░░░░░░░▐█▌░░░░░░░└─▀██
 ██▄░░░▄▄▄▓░░▀█▀░░▓▄▄▄░░░▄██
 ████▄─┘██▌░░░░░░░▐██└─▄████
 █████░░▐█─┬┬┬┬┬┬┬─█▌░░█████
 ████▌░░░▀┬┼┼┼┼┼┼┼┬▀░░░▐████
 █████▄░░░└┴┴┴┴┴┴┴┘░░░▄█████
 ███████▄░░░░░░░░░░░▄███████
 ██████████▄▄▄▄▄▄▄██████████ ]],
                    hl = "String",
                    padding = 1,
                    align = "center",
                },
                { section = "keys",         gap = 1,    padding = 1 },
                { section = "recent_files", indent = 2, padding = 1 },
                { section = "projects",     indent = 2, padding = 1 },
                { section = "startup" },
            },
        },
        picker = {
            enabled = true,
            layouts = {
                ivy = { layout = { height = 0.5 } },
                default = { layout = { height = 0.98, width = 0.98 } },
            },
        },
    },
    init = function()
        ---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
        local progress = vim.defaulttable()
        vim.api.nvim_create_autocmd("LspProgress", {
            ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
            callback = function(ev)
                local client = vim.lsp.get_client_by_id(ev.data.client_id)
                local value = ev.data.params
                .value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
                if not client or type(value) ~= "table" then
                    return
                end
                local p = progress[client.id]

                for i = 1, #p + 1 do
                    if i == #p + 1 or p[i].token == ev.data.params.token then
                        p[i] = {
                            token = ev.data.params.token,
                            msg = ("[%3d%%] %s%s"):format(
                                value.kind == "end" and 100 or value.percentage or 100,
                                value.title or "",
                                value.message and (" **%s**"):format(value.message) or ""
                            ),
                            done = value.kind == "end",
                        }
                        break
                    end
                end

                local msg = {} ---@type string[]
                progress[client.id] = vim.tbl_filter(function(v)
                    return table.insert(msg, v.msg) or not v.done
                end, p)

                local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
                vim.notify(table.concat(msg, "\n"), "info", {
                    id = "lsp_progress",
                    title = client.name,
                    opts = function(notif)
                        notif.icon = #progress[client.id] == 0 and " "
                            or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
                    end,
                })
            end,
        })

        local Snacks = require("snacks")

        -- Toggle zen
        Snacks.toggle.zen():map("<leader>uz")

        -- Toggle markdown render
        Snacks.toggle
            .new({
                id = "render_markdown",
                name = "Render Markdown",
                get = function()
                    return require("render-markdown").get()
                end,
                set = function(state)
                    if state then
                        require("render-markdown").enable()
                    else
                        require("render-markdown").disable()
                    end
                end,
            })
            :map("<leader>um")

        -- Toggle AI Codeium
        Snacks.toggle
            .new({
                id = "aicompletion",
                name = "Codeium",
                get = function()
                    if vim.g.aicompletion_enable == nil then
                        vim.g.aicompletion_enable = true
                    end
                    return vim.g.aicompletion_enable
                end,
                set = function(state)
                    if state then
                        vim.g.aicompletion_enable = true
                        vim.cmd("Codeium Toggle")
                    else
                        vim.g.aicompletion_enable = false
                        vim.cmd("Codeium Toggle")
                    end
                end,
            })
            :map("<leader>uc")

        -- toggle completion
        Snacks.toggle({
            name = "Blink cmp",
            get = function()
                if vim.b.completion == nil then
                    vim.b.completion = true
                end
                return vim.b.completion
            end,
            set = function(state)
                vim.b.completion = state
            end,
        }):map("<leader>u/")

        -- toggle treesitter_context
        Snacks.toggle
            .new({
                id = "treesitter_context",
                name = "Treesitter context",
                get = function()
                    if vim.g.tscontext == nil then
                        vim.g.tscontext = false
                    end
                    return vim.g.tscontext
                end,
                set = function(state)
                    if state then
                        vim.g.tscontext = true
                        vim.cmd("TSContext enable")
                    else
                        vim.g.tscontext = false
                        vim.cmd("TSContext disable")
                    end
                end,
            })
            :map("<leader>ut")

        -- toggle colorscheme between catppuccin and monoglow
        Snacks.toggle
            .new({
                id = "colorscheme",
                name = "colorschemes",
                get = function()
                    return vim.g.colors_name == "rosebones"
                end,
                set = function(state)
                    if state then
                        vim.api.nvim_command("colorscheme rosebones")
                    else
                        vim.api.nvim_command("colorscheme zenbones")
                    end
                end,
            })
            :map("<leader>us")

        -- toggle symbol usage
        Snacks.toggle
            .new({
                id = "symbol_usage",
                name = "Symbol Usage",
                get = function()
                    return require("symbol-usage").is_enabled()
                end,
                set = function()
                    require("symbol-usage").toggle_globally()
                end,
            })
            :map("<leader>uy")

        -- toggle tiny-inline-diagnostic
        Snacks.toggle
            .new({
                id = "tiny_inline_diagnostic",
                name = "Tiny Inline Diagnostic",
                get = function()
                    return not require("tiny-inline-diagnostic").is_disabled()
                end,
                set = function(state)
                    if state then
                        require("tiny-inline-diagnostic").enable()
                        vim.diagnostic.config({ virtual_text = false })
                    else
                        require("tiny-inline-diagnostic").disable()
                        vim.diagnostic.config({ virtual_text = true })
                    end
                end,
            })
            :map("<leader>ud")
    end,
}

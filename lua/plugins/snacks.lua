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
        underline = true, -- underline the start of the scope
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
        scroll = { enabled = false },
        scratch = { enabled = true },
        statuscolumn = { enabled = true },
        toggle = { enabled = true },
        words = {
            enabled = false,
            jumplist = false,
            modes = { "n" },
        },
        zen = { enabled = true },
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

        ---Toggle
        local Snacks = require("snacks")
        Snacks.toggle.zen():map("<leader>uz")
        Snacks.toggle
            .new({
                id = "render_markdown",
                name = "Render Markdown",
                get = function()
                    return vim.g.render_markdown_enable
                end,
                set = function(state)
                    if state then
                        vim.g.render_markdown_enable = true
                        require("render-markdown").enable()
                    else
                        vim.g.render_markdown_enable = false
                        require("render-markdown").disable()
                    end
                end,
            })
            :map("<leader>um")
        Snacks.toggle
            .new({
                id = "aicompletion",
                name = "Inline AI Completion",
                get = function()
                    if vim.g.aicompletion_enable == nil then
                        vim.g.aicompletion_enable = true
                    end
                    return vim.g.aicompletion_enable
                end,
                set = function(state)
                    if state then
                        vim.g.aicompletion_enable = true
                        vim.cmd("Minuet virtualtext enable")
                        vim.cmd("Minuet blink enable")
                    else
                        vim.g.aicompletion_enable = false
                        vim.cmd("Minuet blink disable")
                    end
                end,
            })
            :map("<leader>uc")

        -- toggle completion
        Snacks.toggle({
            name = "Completion",
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
    end,
}

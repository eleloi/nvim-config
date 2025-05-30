local keys = require("config.plugins.snacks.keys")

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
        indent = {
            enabled = true,
            indent = {
                only_scope = true,
                only_current = true,
            },
        },
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

return {
    ---Files
    {
        "<leader>ff",
        function()
            Snacks.picker.files({
                hidden = true,
                matcher = { frecency = true },
            })
        end,
        desc = "Find files",
    },
    {
        "<leader>fF",
        function()
            Snacks.picker.files({
                hidden = true,
                ignored = true,
                matcher = { frecency = true },
            })
        end,
        desc = "Find all files",
    },
    {
        "<leader>fg",
        function()
            Snacks.picker.grep({ layout = "ivy" })
        end,
        desc = "Find grep",
    },
    {
        "<leader>fo",
        function()
            Snacks.picker.smart()
        end,
        desc = "Find oldfiles",
    },
    {
        "<leader>fa",
        function()
            local current_file_path = vim.fs.dirname(vim.fn.expand("%:p"))
            Snacks.picker.files({
                dirs = { current_file_path },
            })
        end,
        desc = "Find adjacent",
    },
    ---Projects
    {
        "<leader>fp",
        function()
            Snacks.picker.projects({ layout = "ivy" })
        end,
        desc = "Find projects",
    },
    ---Picker
    {
        "<leader>fb",
        function()
            Snacks.picker()
        end,
        desc = "All picker builtins",
    },
    {
        "<leader>fr",
        function()
            Snacks.picker.resume()
        end,
        desc = "Resume picker",
    },
    ---Buffers
    {
        "<leader>,",
        function()
            Snacks.picker.buffers({
                layout = "default",
                sort_lastused = true,
                current = false,
                win = {
                    input = {
                        keys = {
                            ["d"] = { "bufdelete", mode = { "n" } },
                            ["<c-x>"] = { "bufdelete", mode = { "i" } },
                        },
                    },
                    list = { keys = { ["d"] = "bufdelete" } },
                },
            })
        end,
        desc = "Pick buffers",
    },
    {
        "<leader>bd",
        function()
            Snacks.bufdelete()
        end,
        desc = "Delete current buffer",
    },
    {
        "<leader>bD",
        function()
            Snacks.bufdelete.other()
        end,
        desc = "Delete all buffers except current",
    },
    ---Notifier
    {
        "<leader>nn",
        function()
            Snacks.notifier.show_history()
        end,
        desc = "Notification history",
    },
    {
        "<leader>nu",
        function()
            Snacks.notifier.hide()
        end,
        desc = "Toggle notifications",
    },
    ---Lsp
    {
        "gr",
        function()
            Snacks.picker.lsp_references({
                layout = "ivy",
            })
        end,
        desc = "Lsp references",
    },
    {
        "gd",
        function()
            Snacks.picker.lsp_definitions({
                layout = "ivy",
            })
        end,
        desc = "Lsp definitions",
    },
    {
        "gt",
        function()
            Snacks.picker.lsp_type_definitions({
                layout = "ivy",
            })
        end,
        desc = "Lsp type definitions",
    },
    {
        "fs",
        function()
            Snacks.picker.lsp_symbols({
                layout = "sidebar",
            })
        end,
        desc = "Lsp document symbols",
    },
    {
        "fS",
        function()
            Snacks.picker.lsp_workspace_symbols({
                layout = "ivy",
            })
        end,
        desc = "Lsp document symbols",
    },
    ---Git
    {
        "<leader>.",
        function()
            Snacks.picker.git_status({
                layout = "ivy",
            })
        end,
        desc = "Changed files",
    },
    {
        "<leader>gl",
        function()
            Snacks.picker.git_log({})
        end,
        desc = "Git log",
    },
    {
        "<leader>gb",
        function()
            Snacks.picker.git_branches({})
        end,
        desc = "Git branches",
    },
    ---Help
    {
        "<leader>fh",
        function()
            Snacks.picker.help()
        end,
        desc = "Help",
    },
    {
        "<leader>fk",
        function()
            Snacks.picker.keymaps()
        end,
        desc = "Keymaps",
    },
    ---Quickfix
    {
        "<leader>fq",
        function()
            Snacks.picker.qflist({
                layout = "ivy",
                on_show = function()
                    vim.cmd.stopinsert()
                end,
            })
        end,
        desc = "Quickfix",
    },
    ---Scratch
    {
        "<leader>sc",
        function()
            Snacks.scratch()
        end,
        desc = "Scratch",
    },
    {
        "<leader>sC",
        function()
            Snacks.scratch.select()
        end,
        desc = "Scratch select",
    },
}

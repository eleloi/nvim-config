---@type LazySpec
return {
    {
        "mikavilpas/yazi.nvim",
        version = "*", -- use the latest stable version
        event = "VeryLazy",
        dependencies = {
            { "nvim-lua/plenary.nvim", lazy = true },
        },
        keys = {
            -- 👇 in this section, choose your own keymappings!
            {
                "<leader>e",
                mode = { "n", "v" },
                "<cmd>Yazi<cr>",
                desc = "Open yazi at the current file",
            },
            {
                -- Open in the current working directory
                "<leader>E",
                "<cmd>Yazi cwd<cr>",
                desc = "Open the file manager in nvim's working directory",
            },
            {
                "<c-up>",
                "<cmd>Yazi toggle<cr>",
                desc = "Resume the last yazi session",
            },
        },
        ---@type YaziConfig | {}
        opts = {
            -- if you want to open yazi instead of netrw, see below for more info
            open_for_directories = false,
            keymaps = {
                show_help = "<f1>",
            },
            floating_window_scaling_factor = 0.90,
            yazi_floating_window_border = "rounded",
        },
        -- 👇 if you use `open_for_directories=true`, this is recommended
        init = function()
            -- mark netrw as loaded so it's not loaded at all.
            --
            -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
            vim.g.loaded_netrwPlugin = 1
        end,
    },
    {
        "nvim-mini/mini.files",
        version = false,
        enabled = false,
        event = "VeryLazy",
        opts = {
            windows = {
                preview = true,
                width_focus = 60,
                width_preview = 80,
            },
        },
        keys = {
            {
                "<leader>e",
                function()
                    require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
                end,
                desc = "Open mini.files (Directory of Current File)",
            },
            -- {
            --     "<leader>fM",
            --     function()
            --         require("mini.files").open(vim.uv.cwd(), true)
            --     end,
            --     desc = "Open mini.files (cwd)",
            -- },
        },
        config = function(_, opts)
            require("mini.files").setup(opts)

            local show_dotfiles = true
            local filter_show = function(fs_entry)
                return true
            end
            local filter_hide = function(fs_entry)
                return not vim.startswith(fs_entry.name, ".")
            end

            local toggle_dotfiles = function()
                show_dotfiles = not show_dotfiles
                local new_filter = show_dotfiles and filter_show or filter_hide
                require("mini.files").refresh({ content = { filter = new_filter } })
            end

            local map_split = function(buf_id, lhs, direction, close_on_file)
                local rhs = function()
                    local new_target_window
                    local cur_target_window = require("mini.files").get_explorer_state().target_window
                    if cur_target_window ~= nil then
                        vim.api.nvim_win_call(cur_target_window, function()
                            vim.cmd("belowright " .. direction .. " split")
                            new_target_window = vim.api.nvim_get_current_win()
                        end)

                        require("mini.files").set_target_window(new_target_window)
                        require("mini.files").go_in({ close_on_file = close_on_file })
                    end
                end

                local desc = "Open in " .. direction .. " split"
                if close_on_file then
                    desc = desc .. " and close"
                end
                vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
            end

            local files_set_cwd = function()
                local cur_entry_path = MiniFiles.get_fs_entry().path
                local cur_directory = vim.fs.dirname(cur_entry_path)
                if cur_directory ~= nil then
                    vim.fn.chdir(cur_directory)
                end
            end

            vim.api.nvim_create_autocmd("User", {
                pattern = "MiniFilesBufferCreate",
                callback = function(args)
                    local buf_id = args.data.buf_id

                    vim.keymap.set(
                        "n",
                        opts.mappings and opts.mappings.toggle_hidden or "g.",
                        toggle_dotfiles,
                        { buffer = buf_id, desc = "Toggle hidden files" }
                    )

                    vim.keymap.set(
                        "n",
                        opts.mappings and opts.mappings.change_cwd or "gc",
                        files_set_cwd,
                        { buffer = args.data.buf_id, desc = "Set cwd" }
                    )

                    map_split(buf_id, opts.mappings and opts.mappings.go_in_horizontal or "<C-w>s", "horizontal", false)
                    map_split(buf_id, opts.mappings and opts.mappings.go_in_vertical or "<C-w>v", "vertical", false)
                    map_split(
                        buf_id,
                        opts.mappings and opts.mappings.go_in_horizontal_plus or "<C-w>S",
                        "horizontal",
                        true
                    )
                    map_split(buf_id, opts.mappings and opts.mappings.go_in_vertical_plus or "<C-w>V", "vertical", true)
                end,
            })

            vim.api.nvim_create_autocmd("User", {
                pattern = "MiniFilesActionRename",
                callback = function(event)
                    Snacks.rename.on_rename_file(event.data.from, event.data.to)
                end,
            })
        end,
    },
}

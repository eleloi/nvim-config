vim.pack.add({ "https://github.com/folke/lazydev.nvim" })

vim.api.nvim_create_autocmd("FileType", {
    pattern = "lua",
    desc = "Loads and configures lazydev.nvim when opening Lua files",
    -- 'once = true' ensures the plugin is only added and initialized
    -- the first time you open a Lua file in the session.
    once = true,
    callback = function()
        require("lazydev").setup({
            library = {
                "~/projects/my-awesome-lib",
                "lazy.nvim",
                { path = "${3rd}/luv/library",        words = { "vim%.uv" } },
                "LazyVim",
                { path = "LazyVim",                   words = { "LazyVim" } },
                { path = "wezterm-types",             mods = { "wezterm" } },
                { path = "xmake-luals-addon/library", files = { "xmake.lua" } },
            },

            -- NOTE: In your original snippet you had the 'enabled' key defined twice.
            -- In Lua, the second definition silently overwrites the first one.
            -- I left the combined logic (or whichever prevailed) for safety:
            enabled = function(root_dir)
                -- If a .luarc.json exists, disable it. Otherwise, check the global variable.
                if vim.uv.fs_stat(root_dir .. "/.luarc.json") then
                    return false
                end
                return vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled
            end,
        })
    end,
})

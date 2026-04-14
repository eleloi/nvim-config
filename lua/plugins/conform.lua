local formatters = {
    css = { "prettierd" },
    go = { "goimports" },
    html = { "prettierd" },
    json = { "jq" },
    kdl = { "kdlfmt" },
    lua = { "stylua" },
    markdown = { "prettierd" },
    nix = { "nixfmt" },
    typ = { "typstyle" },
    typescript = { "prettierd" },
    typescriptreact = { "prettierd" },
    typst = { "typstyle" },
}

return {
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = formatters,
            format_on_save = {
                timeout_ms = 300,
                lsp_format = "fallback",
            },
        },
        init = function()
            vim.o.formatexpr = "v:lua.require('conform').formatexpr()"
        end,
        event = "VeryLazy",
        keys = {
            {
                "<M-f>",
                function()
                    require("conform").format({ lsp_format = "fallback" })
                end,
            },
        },
    },

    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        lazy = false,
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            local ensure_installed = {}
            local seen = {}

            for _, tools in pairs(formatters) do
                for _, tool in ipairs(tools) do
                    if not seen[tool] then
                        table.insert(ensure_installed, tool)
                        seen[tool] = true
                    end
                end
            end
            require("mason-tool-installer").setup({
                ensure_installed = ensure_installed,
                auto_update = true,
                run_on_start = true,
                start_delay = 3000,
                debounce_hours = 5,

                integrations = {
                    ["mason-lspconfig"] = false,
                    ["mason-null-ls"] = false,
                    ["mason-nvim-dap"] = false,
                },
            })
        end,
    },
}

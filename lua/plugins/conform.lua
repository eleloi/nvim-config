local formatters = {
    lua = { "stylua" },
    python = { "ruff" },
    rust = { "rustfmt" },
    typescript = { "prettierd" },
    typescriptreact = { "prettierd" },
    html = { "prettierd" },
    css = { "prettierd" },
    go = { "gofmt", "goimports" },
    json = { "jq" },
    nix = { "nixfmt" },
    typ = { "typstyle" },
    typst = { "typstyle" },
}

return {
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
}

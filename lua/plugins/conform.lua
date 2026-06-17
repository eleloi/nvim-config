vim.pack.add({
    "https://github.com/stevearc/conform.nvim",
})

local formatters = {
    css = { "prettierd" },
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

require("conform").setup({
    formatters_by_ft = formatters,
    format_on_save = {
        timeout_ms = 300,
        lsp_format = "fallback",
    },
})

vim.o.formatexpr = "v:lua.require('conform').formatexpr()"

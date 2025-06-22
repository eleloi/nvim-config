local lsp_tools = require("config.plugins.lsp_tools")

local on_attach = function(_, bufnr)
    local opts = { buffer = bufnr }
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gD", function()
        vim.api.nvim_command("vsplit")
        vim.lsp.buf.definition()
    end, opts)
    vim.keymap.set("n", "<leader>cD", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.cmd.autocmd("BufWritePre", "<buffer>", "lua vim.lsp.buf.format()")
end

return {
    {
        "williamboman/mason.nvim",
        config = true,
        event = "VeryLazy",
    },
    {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
        dependencies = {
            "williamboman/mason.nvim",
            "davidosomething/format-ts-errors.nvim",
            "saghen/blink.cmp",
        },
        config = function()
            local capabilities = require("blink.cmp").get_lsp_capabilities()

            local all_servers = vim.tbl_extend("force", lsp_tools.mason, lsp_tools.noMason)

            vim.filetype.add({
                pattern = {
                    ["compose.*%.ya?ml"] = "yaml.docker-compose",
                    ["docker%-compose.*%.ya?ml"] = "yaml.docker-compose",
                },
            })
            vim.keymap.set("n", "[d", function()
                vim.diagnostic.jump({ count = -1, float = true })
            end)
            vim.keymap.set("n", "]d", function()
                vim.diagnostic.jump({ count = 1, float = true })
            end)

            local base_params = {
                on_attach = on_attach,
                capabilities = capabilities,
            }
            for server_name, params in pairs(all_servers) do
                vim.lsp.enable(server_name)
                local server_params = vim.tbl_extend("force", base_params, params)
                vim.lsp.config[server_name] = server_params
            end
        end,
    },

    -- use mason-lspconfig to install lsp tools automatically and setup lspconfig
    {
        "mason-org/mason-lspconfig.nvim",
        enabled = true,
        dependencies = { { "mason-org/mason.nvim", opts = {} } },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = vim.tbl_keys(lsp_tools.mason),
                automatic_enable = false,
            })
        end,
    },
    {
        "dmmulroy/tsc.nvim",
        ft = { "typescript", "typescriptreact" },
        config = true,
    },
}

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
            vim.diagnostic.config({
                virtual_text = {
                    prefix = "●",
                },
                severity_sort = true,
                float = {
                    source = true,
                },
            })
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

    {
        "someone-stole-my-name/yaml-companion.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "b0o/schemastore.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            local cfg = require("yaml-companion").setup({
                -- detect k8s schemas based on file content
                builtin_matchers = {
                    kubernetes = { enabled = true },
                },

                schemas = {
                    -- not loaded automatically, manually select with
                    -- :Telescope yaml_schema
                    {
                        name = "Argo CD Application",
                        uri =
                        "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json",
                    },
                    {
                        name = "Argo CD ApplicationSet",
                        uri =
                        "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/applicationset_v1alpha1.json",
                    },
                    {
                        name = "Argo CD AppProject",
                        uri =
                        "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/appproject_v1alpha1.json",
                    },

                    {
                        name = "SealedSecret",
                        uri =
                        "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/bitnami.com/sealedsecret_v1alpha1.json",
                    },
                    -- schemas below are automatically loaded, but added
                    -- them here so that they show up in the statusline
                    {
                        name = "Kustomization",
                        uri = "https://json.schemastore.org/kustomization.json",
                    },
                    {
                        name = "GitHub Workflow",
                        uri = "https://json.schemastore.org/github-workflow.json",
                    },
                },

                lspconfig = {
                    settings = {
                        yaml = {
                            format = { enable = true },
                            validate = true,
                            schemaStore = {
                                enable = false,
                                url = "",
                            },

                            -- schemas from store, matched by filename
                            -- loaded automatically
                            schemas = require("schemastore").yaml.schemas({
                                select = {
                                    "kustomization.yaml",
                                    "GitHub Workflow",
                                },
                            }),
                        },
                        redhat = { telemetry = { enable = false } },
                    },
                },
            })

            vim.lsp.config("yamlls", cfg)
            vim.lsp.enable("yamlls")

            require("telescope").load_extension("yaml_schema")
            -- get schema for current buffer
            local function get_schema()
                local schema = require("yaml-companion").get_buf_schema(0)
                if schema.result[1].name == "none" then
                    return ""
                end
                return schema.result[1].name
            end

            require("lualine").setup({
                sections = {
                    lualine_x = { "fileformat", "filetype", get_schema },
                },
            })
        end,
    },
}

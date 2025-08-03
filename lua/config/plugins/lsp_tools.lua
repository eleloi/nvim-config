return {
    mason = {
        lua_ls = {
            settings = { Lua = { telemetry = { enable = false } } },
            on_init = function(client)
                if client.workspace_folders then
                    local path = client.workspace_folders[1].name
                    if vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc") then
                        return
                    end
                end

                client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
                    runtime = {
                        version = "LuaJIT",
                    },
                    workspace = {
                        checkThirdParty = true,
                        library = {
                            vim.env.VIMRUNTIME,
                            "~/.local/share/nvim/lazy",
                            "/home/eleloi/.config/nvim/lazy",
                            "${3rd}/luv/library",
                        },
                    },
                })
            end,
        },
        rust_analyzer = {},
        eslint = {},
        basedpyright = {},
        ruff = {},
        gopls = {},
        biome = {},
        golangci_lint_ls = {},
        tinymist = {
            filetypes = { "typst", "typ" },
            settings = {
                formatterMode = "typstyle",
                exportPdf = "onType",
                semanticTokens = "disable",
            },
        },
        astro = {
            on_init = function()
                vim.g.astro_typescript = "enable"
            end,
        },
        bashls = { filetypes = { "bash", "sh", "zsh" } },
        ts_ls = {},
        svelte = {},
        tailwindcss = {},
        docker_compose_language_service = {},
        dockerls = {},
        yamlls = {
            settings = {
                redhat = { telemetry = { enable = false } },
                yaml = {
                    schemas = {
                        kubernetes = "k8s-*.yaml",
                        ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
                        ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
                    },
                },
            },
        },
        taplo = {},
        jsonls = {
            settings = {
                json = {
                    -- Schemas https://www.schemastore.org
                    schemas = {
                        {
                            fileMatch = { "package.json" },
                            url = "https://json.schemastore.org/package.json",
                        },
                        {
                            fileMatch = { "tsconfig*.json" },
                            url = "https://json.schemastore.org/tsconfig.json",
                        },
                        {
                            fileMatch = {
                                ".prettierrc",
                                ".prettierrc.json",
                                "prettier.config.json",
                            },
                            url = "https://json.schemastore.org/prettierrc.json",
                        },
                        {
                            fileMatch = { ".eslintrc", ".eslintrc.json" },
                            url = "https://json.schemastore.org/eslintrc.json",
                        },
                        {
                            fileMatch = { ".babelrc", ".babelrc.json", "babel.config.json" },
                            url = "https://json.schemastore.org/babelrc.json",
                        },
                        {
                            fileMatch = { "lerna.json" },
                            url = "https://json.schemastore.org/lerna.json",
                        },
                        {
                            fileMatch = { "now.json", "vercel.json" },
                            url = "https://json.schemastore.org/now.json",
                        },
                        {
                            fileMatch = {
                                ".stylelintrc",
                                ".stylelintrc.json",
                                "stylelint.config.json",
                            },
                            url = "http://json.schemastore.org/stylelintrc.json",
                        },
                    },
                },
            },
        },
    },
    noMason = {
        nushell = {},
        nu = {},
        nixd = {
            cmd = { "nixd" },
            settings = {
                nixpkgs = {
                    expr = "import <nixpkgs> { }",
                },
                options = {
                    nixos = {
                        expr =
                        '(builtins.getFlake "/home/eleloi/nixos-config/flake.nix").nixosConfigurations."bob".options',
                    },
                    home_manager = {
                        expr =
                        '(builtins.getFlake "/home/eleloi/nixos-config/flake.nix").homeConfigurations."eleloi".options',
                    },
                },
            },
        },
    },
}

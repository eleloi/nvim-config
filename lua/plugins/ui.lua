return {
    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
        opts = {
            input = {
                border = "rounded",
                relative = "cursor",
                prefer_width = 40,
            },
            select = {
                backend = { "telescope", "fzf_lua", "builtin" },
                trim_prompt = true,
                builtin = {
                    border = "rounded",
                    relative = "cursor",
                },
            },
        },
    },
    {
        "b0o/incline.nvim",
        event = "BufReadPre",
        priority = 1200,
        config = function()
            local helpers = require("incline.helpers")
            require("incline").setup({
                window = {
                    margin = { horizontal = 0, vertical = 0 },
                    padding = 0,
                },
                render = function(props)
                    -- Solo mostramos la burbuja si la ventana NO tiene el foco
                    if props.focused then
                        return ""
                    end

                    local full_path = vim.api.nvim_buf_get_name(props.buf)
                    local filename = vim.fn.fnamemodify(full_path, ":t")
                    -- Obtenemos la ruta relativa al directorio de trabajo (más limpio que la absoluta)
                    local relative_path = vim.fn.fnamemodify(full_path, ":.")
                    
                    if filename == "" then
                        return { { "[No Name]", gui = "italic" } }
                    end

                    local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
                    local modified = vim.bo[props.buf].modified and " ●" or ""

                    -- Dividimos la ruta para dar un color más tenue al directorio y resaltar el nombre
                    local dirname = vim.fn.fnamemodify(relative_path, ":h")
                    if dirname == "." then dirname = "" else dirname = dirname .. "/" end

                    return {
                        { (ft_icon or "") .. " ", guifg = ft_color },
                        { dirname,                guifg = "#808080" }, -- Color gris tenue para el directorio
                        { filename,               gui = "bold" },
                        { modified,               guifg = "#e67e80" },
                        { " ",                    guibg = "none" },
                    }
                end,
            })
        end,
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = "BufReadPost",
        opts = {
            signs = true,
            keywords = {
                FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
                TODO = { icon = " ", color = "info" },
                HACK = { icon = " ", color = "warning" },
                WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
                PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
                NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
            },
            highlight = {
                multiline = true,
                multiline_pattern = "^.",
                multiline_context = 10,
                before = "",
                keyword = "wide",
                after = "fg",
                -- Volvemos al estándar: palabra clave seguida de dos puntos
                pattern = [[.*<(KEYWORDS)\s*:]], 
                comments_only = true, -- Solo resaltamos dentro de comentarios
            },
        },
    },
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy", -- Cargamos después de lo principal
        priority = 1000, -- Prioridad alta para que sobrescriba los diagnósticos por defecto
        config = function()
            require("tiny-inline-diagnostic").setup({
                signs = {
                    left = "",
                    right = "",
                    diag = "",
                    arrow = "  ",
                    up_arrow = "  ",
                    vertical = " │",
                    vertical_end = " └",
                },
                blend = {
                    factor = 0.2, -- Fondo muy sutil y transparente
                },
                options = {
                    show_source = true, -- Mostrar de qué LSP viene (ej: gopls, lua_ls)
                    use_icons_from_diagnostic = true, -- Reutiliza tus iconos de lsp.lua
                    add_padding = true,
                    multilines = {
                        enabled = true,
                        always_show = false, -- Solo muestra multilínea si es necesario
                    },
                    show_all_diags_on_line = false, -- Solo el diagnóstico más importante por línea
                },
            })
            -- Desactivamos el virtual text por defecto de Neovim para que no se pisen
            vim.diagnostic.config({ virtual_text = false })
        end,
    },
    {
        "Wansmer/symbol-usage.nvim",
        event = "LspAttach", -- Solo cuando hay un LSP activo
        config = function()
            require("symbol-usage").setup({
                text_format = function(symbol)
                    local res = {}
                    if symbol.references then
                        local usage = symbol.references > 0 and ("󰈇 %d refs"):format(symbol.references) or "󰈇 0 refs"
                        table.insert(res, usage)
                    end
                    if symbol.definitions then
                        local defs = symbol.definitions > 0 and ("󰡱 %d defs"):format(symbol.definitions) or ""
                        if defs ~= "" then table.insert(res, defs) end
                    end
                    if symbol.implementations then
                        local impls = symbol.implementations > 0 and ("󰡱 %d impls"):format(symbol.implementations) or ""
                        if impls ~= "" then table.insert(res, impls) end
                    end
                    return table.concat(res, " | ")
                end,
                -- Sobriedad absoluta: colores tenues
                hl = { link = "Comment" },
                vt_position = "above", -- Encima de la línea, como un comentario de metadatos
            })
        end,
    },
}

-- Improve markdown view

return {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    opts = {
        enabled = false,
        preset = "none",

        -- Headings: iconos overlay con fondo completo
        heading = {
            icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
            position = "overlay",
            width = "full",
            sign = true,
            border = false,
        },

        -- Code blocks: borde fino, ancho del bloque, icono de lenguaje a la izquierda
        code = {
            border = "thin",
            width = "block",
            left_pad = 2,
            right_pad = 2,
            language_icon = true,
            language_name = true,
            position = "left",
        },

        -- Tablas: bordes redondeados
        pipe_table = {
            preset = "round",
            cell = "padded",
        },

        -- Bullets: iconos por nivel de anidacion
        bullet = {
            icons = { "●", "○", "◆", "◇" },
            left_pad = 0,
            right_pad = 1,
        },

        -- Checkboxes
        checkbox = {
            enabled = true,
            bullet = false,
        },

        -- Separadores
        dash = {
            icon = "─",
            width = "full",
        },

        -- Callouts: solo GitHub (filtrar obsidian)
        completions = {
            filter = {
                callout = function(value)
                    return value.category ~= "obsidian"
                end,
            },
        },

        -- Links con iconos
        link = {
            enabled = true,
        },

        -- Anti-conceal: ocultar renderizado en la linea del cursor
        anti_conceal = {
            enabled = true,
            above = 0,
            below = 0,
        },
    },
}

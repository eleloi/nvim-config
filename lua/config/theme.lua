-- theme choice is saved in a file for persistence on restart
-- could use a plugin instead, but hey, this is more fun
-- lualine theme gets stored separately due to possible naming differences

local theme_file = vim.fn.stdpath("config") .. "/lua/config/saved_theme"

vim.pack.add({
    -- mini summer, winter, autumn, sprint
    "https://github.com/nvim-mini/mini.hues",
    -- zenbones
    "https://github.com/rktjmp/lush.nvim", -- dependency
    "https://github.com/zenbones-theme/zenbones.nvim",
    -- gruvbox
    "https://github.com/ellisonleao/gruvbox.nvim",
})

_G.load_theme = function()
    local file = io.open(theme_file, "r")
    if file then
        vim.cmd("colorscheme " .. file:read("*l"))
        -- require("lualine").setup({ options = { theme = file:read("*l") } })
        file:close()
    end
end

local themes = { --add more themes here, if installed
    { "miniwinter", "miniwinter" },
    { "minisummer", "minisummer" },
    { "miniautumn", "miniautumn" },
    { "minispring", "minispring" },
    { "rosebones",  "rosebones" },
    { "gruvbox",    "gruvbox" },
}

local current_theme_index = 1

_G.switch_theme = function()
    current_theme_index = current_theme_index % #themes + 1
    local colorscheme, lualine = unpack(themes[current_theme_index])
    vim.cmd("colorscheme " .. colorscheme)
    -- require("lualine").setup({ options = { theme = lualine } })
    local file = io.open(theme_file, "w")
    if file then
        file:write(colorscheme .. "\n" .. lualine)
        file:close()
    end
end

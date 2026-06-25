-- theme choice is saved in a file for persistence on restart
-- could use a plugin instead, but hey, this is more fun
-- lualine theme gets stored separately due to possible naming differences

local M = {
  theme_file = vim.fn.stdpath("config") .. "/lua/config/saved_theme",
  themes = { --add more themes here, if installed
    { "rosebones", "rosebones" },
    { "gruvbox",   "gruvbox" },
    { "eldritch",  "eldritch" },
  },
  current_theme_index = 1,
}

M.setup = function()
  vim.pack.add({
    -- zenbones
    "https://github.com/rktjmp/lush.nvim", -- dependency
    "https://github.com/zenbones-theme/zenbones.nvim",
    -- gruvbox
    "https://github.com/ellisonleao/gruvbox.nvim",
    -- eldrich
    "https://github.com/eldritch-theme/eldritch.nvim",
  })

  require("eldritch").setup({
    transparent = true,
    styles = {
      sidebars = "dark",
      floats = "dark",
    },
  })
end

M.load_theme = function()
  local file = io.open(M.theme_file, "r")
  if file then
    vim.cmd("colorscheme " .. file:read("*l"))
    -- require("lualine").setup({ options = { theme = file:read("*l") } })
    file:close()
  end
end


M.switch_theme = function()
  M.current_theme_index = M.current_theme_index % #M.themes + 1
  local colorscheme, lualine = unpack(M.themes[M.current_theme_index])
  vim.cmd("colorscheme " .. colorscheme)
  require("lualine").setup({ options = { theme = lualine } })
  local file = io.open(M.theme_file, "w")
  if file then
    file:write(colorscheme .. "\n" .. lualine)
    file:close()
  end
  print("Theme: " .. colorscheme)
end

return M

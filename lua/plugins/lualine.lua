vim.pack.add({
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",       -- dependency
  'https://tangled.org/bpavuk.neocities.org/jj-log.nvim', -- jj log access
})

require('jj-log').setup({
  -- these are default options
  out_waiting = "...",
  out_no_jj_repo = "~no_jj~",
  out_no_desc = "~no_desc~",
  max_desc_length = 47, -- including truncation dots, that's 50
})


require("lualine").setup({
  options = {
    theme = "auto",
    icons_enabled = true,
    globalstatus = true,
  },
  extensions = { "quickfix" },
  sections = {
    lualine_a = { { "mode", upper = true } },
    lualine_b = {
      function()
        return vim.b.jj_desc or ""
      end,
      { "branch", icon = "" },
      "db_ui#statusline",
    },
    lualine_c = { { "filename", file_status = true, path = 1 } },
    lualine_x = {
      "diagnostics",
      "diff",
    },
    lualine_y = { "filetype" },
    lualine_z = { "location" },
  },
  winbar = {
    lualine_a = {},
    lualine_b = {},
    inactive_lualine_c = { { "filename", file_status = true, path = 1 } },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  inactive_winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
})

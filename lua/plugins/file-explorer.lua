vim.pack.add({
  "https://github.com/mikavilpas/yazi.nvim",
  "https://github.com/nvim-lua/plenary.nvim", -- dependency
})

require("yazi").setup({
  open_for_directories = false,
  open_multiple_tabs = true,
  keymaps = {
    show_help = "<f1>",
  },
  floating_window_scaling_factor = 0.90,
  yazi_floating_window_border = "rounded",
  integrations = {
    grep_in_directory = function(directory)
      require('fzf-lua').live_grep({ cwd = directory })
    end
  }
})

-- 👇 if you use `open_for_directories=true`, this is recommended
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

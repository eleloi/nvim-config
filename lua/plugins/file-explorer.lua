vim.pack.add({
    "https://github.com/mikavilpas/yazi.nvim",
    "https://github.com/nvim-lua/plenary.nvim", -- dependency
})

require("yazi").setup({
    open_for_directories = false,
    keymaps = {
        show_help = "<f1>",
    },
    floating_window_scaling_factor = 0.90,
    yazi_floating_window_border = "rounded",
})

-- 👇 if you use `open_for_directories=true`, this is recommended
vim.g.loaded_netrwPlugin = 1

--- Use treesitter to **autoclose** and **autorename** html tag

vim.pack.add({
  "https://github.com/windwp/nvim-ts-autotag",
})

require("nvim-ts-autotag").setup({
  autotag = { enable = true },
})

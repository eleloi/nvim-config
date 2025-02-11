-- Add comments

return {
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    event = "VeryLazy",
    config = true,
  },
  {
    "echasnovski/mini.comment",
    version = "*",
    event = "VeryLazy",
    config = true,
  },
}

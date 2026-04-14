return {
  "rgroli/other.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<leader>O",
      "<CMD>Other<CR>",
      desc = "Other",
      mode = "n",
    },
  },
  config = function()
    require("other-nvim").setup({
      mappings = { "golang" },
      transformers = {},
      style = {
        border = "solid",
        seperator = "|",
        width = 0.7,
        minHeight = 2,
      },
    })
  end,
}

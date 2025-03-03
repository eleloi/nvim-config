-- Refactoring plugin, works in visual mode

return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-treesitter/nvim-treesitter" },
  },
  keys = {
    {
      "<leader>cr",
      function()
        require("telescope").extensions.refactoring.refactors()
      end,
      mode = { "n", "v" },
      desc = "Refactoring menu",
    },
  },
  config = function()
    require("refactoring").setup({})
    require("telescope").load_extension("refactoring")
  end,
}
